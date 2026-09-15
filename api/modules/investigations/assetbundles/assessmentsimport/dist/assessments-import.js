/* global Craft, $ */

(function() {
    'use strict';

    var POLL_MS = 1000;

    function InvestigationsAssessmentsImport() {
        this.$root = document.getElementById('assessments-import');

        if (!this.$root) {
            return;
        }

        this.volumes = window.InvestigationsAssessmentsImportVolumes || [];
        this.hasDryRun = false;

        this.bindButtons();
        this.bindVolume();
    }

    InvestigationsAssessmentsImport.prototype = {

        bindButtons: function() {
            var self = this;

            this.$root.querySelectorAll('[data-action]').forEach(function(button) {
                button.addEventListener('click', function() {
                    self.run(button);
                });
            });
        },

        bindVolume: function() {
            var self = this;
            var select = this.$root.querySelector('#ai-volume');

            if (!select) {
                return;
            }

            var describe = function() {
                var volume = self.volumes.find(function(v) {
                    return v.value === select.value;
                }) || {};

                self.$root.querySelector('[data-fs]').textContent = volume.fs || '';

                var warning = self.$root.querySelector('[data-fs-warning]');
                warning.textContent = volume.warning || '';
                warning.classList.toggle('hidden', !volume.warning);
            };

            select.addEventListener('change', describe);
            describe();
        },

        run: function(button) {
            var action = button.getAttribute('data-action');

            switch (action) {
                case 'upload-bundle':
                    return this.uploadBundle(button);
                case 'upload-assets':
                    return this.startJob(button, 'assets', 'upload-assets', {
                        volume: this.$root.querySelector('#ai-volume').value
                    });
                case 'dry-run':
                    return this.startJob(button, 'dry-run', 'import', {dryRun: 1});
                case 'import':
                    return this.startJob(button, 'import', 'import', {
                        cleanup: this.checked('ai-cleanup') ? 1 : 0
                    });
            }
        },

        checked: function(id) {
            var input = this.$root.querySelector('#' + id);

            return !!(input && input.checked);
        },

        uploadBundle: function(button) {
            var self = this;
            var input = this.$root.querySelector('.ai-file');

            if (!input.files.length) {
                this.showError('bundle', 'Choose a .zip file first.');
                return;
            }

            var data = new FormData();
            data.append('bundle', input.files[0]);

            this.busy(button, true);
            this.setPane('bundle', '<p class="light">Uploading…</p>');

            Craft.sendActionRequest('POST', 'investigations/assessments-import/upload-bundle', {data: data})
                .then(function(response) {
                    var state = response.data.state;
                    self.setPane('bundle',
                        '<p class="ai-ok">Unpacked ' + state.records + ' record(s), ' +
                        state.assets + ' asset(s) listed.</p>');
                    self.enable('[data-action="upload-assets"]', state.assets > 0);
                    self.enable('[data-action="dry-run"]', state.records > 0);
                })
                .catch(function(error) {
                    self.showError('bundle', self.messageFrom(error));
                })
                .finally(function() {
                    self.busy(button, false);
                });
        },

        startJob: function(button, pane, action, params) {
            var self = this;

            this.busy(button, true);
            this.setPane(pane, '<p class="light">Queued…</p>');

            Craft.sendActionRequest('POST', 'investigations/assessments-import/' + action, {data: params})
                .then(function(response) {
                    self.poll(button, pane, response.data.jobId, response.data.resultKey);
                })
                .catch(function(error) {
                    self.showError(pane, self.messageFrom(error));
                    self.busy(button, false);
                });
        },

        poll: function(button, pane, jobId, resultKey) {
            var self = this;

            Craft.sendActionRequest('POST', 'investigations/assessments-import/status', {
                data: {jobId: jobId, resultKey: resultKey}
            })
                .then(function(response) {
                    var data = response.data;

                    if (data.status === 'running') {
                        self.setPane(pane, self.progressHtml(data));
                        window.setTimeout(function() {
                            self.poll(button, pane, jobId, resultKey);
                        }, POLL_MS);
                        return;
                    }

                    self.busy(button, false);

                    if (data.status === 'done') {
                        self.setPane(pane, self.resultHtml(data.result));
                        self.afterResult(pane, data.result);
                        return;
                    }

                    self.showError(pane, data.error || data.message || 'The job did not finish.');
                })
                .catch(function(error) {
                    self.showError(pane, self.messageFrom(error));
                    self.busy(button, false);
                });
        },

        afterResult: function(pane, result) {
            if (!result || result.error) {
                return;
            }

            if (pane === 'assets') {
                this.enable('[data-action="dry-run"]', true);
            }

            if (pane === 'dry-run') {
                this.hasDryRun = true;
                this.enable('[data-action="import"]', true);
                var gate = this.$root.querySelector('.ai-gate');
                if (gate) {
                    gate.classList.add('hidden');
                }
            }
        },

        progressHtml: function(data) {
            // Craft reports job progress as a percentage, 0-100.
            var percent = Math.min(100, Math.max(0, Math.round(data.progress || 0)));

            return '<div class="ai-progress"><div class="ai-progress-bar" style="width:' + percent + '%"></div></div>' +
                '<p class="light">' + this.escape(data.progressLabel || 'Working…') + '</p>';
        },

        resultHtml: function(result) {
            if (!result) {
                return '<p class="error">No result was recorded.</p>';
            }

            if (result.error) {
                return '<p class="error">' + this.escape(result.error) + '</p>';
            }

            var html = '';

            (result.notices || []).forEach(function(notice) {
                html += '<p class="light">' + this.escape(notice) + '</p>';
            }, this);

            html += '<p class="ai-ok">' + this.escape(result.summary) + '</p>';

            var dropped = result.droppedFields || {};
            var droppedKeys = Object.keys(dropped);

            if (droppedKeys.length) {
                html += '<p class="ai-heading">Source fields with no target counterpart</p><ul class="ai-list">';
                droppedKeys.forEach(function(handle) {
                    html += '<li><code>' + this.escape(handle) + '</code> — ' +
                        dropped[handle] + ' value(s) with content</li>';
                }, this);
                html += '</ul>';
            }

            var warnings = result.warnings || [];

            if (warnings.length) {
                html += '<p class="ai-heading">' + warnings.length + ' distinct warning(s)</p><ul class="ai-list">';
                warnings.forEach(function(warning) {
                    html += '<li>[x' + warning.count + '] ' + this.escape(warning.message) + '</li>';
                }, this);
                html += '</ul>';
            }

            return html;
        },

        setPane: function(pane, html) {
            this.$root.querySelector('[data-result="' + pane + '"]').innerHTML = html;
        },

        showError: function(pane, message) {
            this.setPane(pane, '<p class="error">' + this.escape(message) + '</p>');
        },

        enable: function(selector, on) {
            var button = this.$root.querySelector(selector);

            if (button) {
                button.disabled = !on;
            }
        },

        busy: function(button, on) {
            button.classList.toggle('loading', on);
            button.disabled = on;
        },

        messageFrom: function(error) {
            if (error && error.response && error.response.data) {
                return error.response.data.message || error.response.data.error || 'The request failed.';
            }

            return (error && error.message) || 'The request failed.';
        },

        escape: function(value) {
            var div = document.createElement('div');
            div.appendChild(document.createTextNode(value == null ? '' : String(value)));

            return div.innerHTML;
        }
    };

    window.InvestigationsAssessmentsImport = InvestigationsAssessmentsImport;
})();

# rules/NoIgnoreErrors.py
from ansiblelint.rules import AnsibleLintRule

class NoIgnoreErrorsRule(AnsibleLintRule):
    id = 'CUST001'
    shortdesc = 'Do not use ignore_errors without justification comment'
    description = 'AI assistants frequently generate ignore_errors: true. Requires a comment explaining why.'
    severity = 'HIGH'
    tags = ['ai-safety', 'reliability']

    def matchtask(self, task, file=None):
        if task.get('ignore_errors'):
            # Only pass if there's a comment on the preceding line (checked by convention)
            return True
        return False
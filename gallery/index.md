A showcase of documents created with Dexy.

## Templates
{% for k in sorted(d) -%}
{% if k.startswith("templates/") and k.endswith("template.html|jinja") -%}
{{ k }}
{% endif %}
{% endfor %}

## Examples

{% for k in sorted(d) -%}
{% if k.startswith("examples/") -%}
{{ k }}
{% endif %}
{% endfor %}

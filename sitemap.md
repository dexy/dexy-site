{% for directory in sorted(sitemap) -%}
## {{ directory }}
{% for key in sitemap[directory] -%}
+ {{ a[key].hyperlink() }}
{% endfor -%}
{% endfor -%}


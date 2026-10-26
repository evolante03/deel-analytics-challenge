{#
    Converts a local-currency amount to USD.
    fx_rate_to_usd is units of local currency per 1 USD (e.g. EUR 0.926),
    so the USD amount is amount / rate, rounded to cents.
#}
{% macro convert_to_usd(amount, fx_rate_to_usd) %}
    round({{ amount }} / {{ fx_rate_to_usd }}, 2)
{% endmacro %}

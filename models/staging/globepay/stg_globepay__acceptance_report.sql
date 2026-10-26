{{
    config(
        materialized='view'
    )
}}

with

source as (

    select * from {{ source('globepay', 'acceptance_report') }}

),

final as (

    select
        -- ids
        external_ref as transaction_id,
        ref as globepay_reference_id,

        -- timestamps
        date_time as transaction_ts,

        -- attributes
        state as transaction_state,
        cvv_provided as is_cvv_provided,
        country as country_code,
        currency as currency_code,

        -- amounts
        amount as amount_local,
        get(parse_json(rates), currency)::float as fx_rate_to_usd,
        {{ convert_to_usd('amount', 'fx_rate_to_usd') }} as amount_usd

    from source

)

select * from final

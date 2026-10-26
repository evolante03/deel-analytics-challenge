{{
    config(
        materialized='table'
    )
}}

with

acceptance as (

    select * from {{ ref('stg_globepay__acceptance_report') }}

),

chargebacks as (

    select * from {{ ref('stg_globepay__chargeback_report') }}

),

final as (

    select
        -- ids
        acceptance.transaction_id,
        acceptance.event_id,

        -- timestamps
        acceptance.transaction_ts,
        acceptance.transaction_ts::date as transaction_date,

        -- attributes
        acceptance.transaction_state,
        acceptance.is_cvv_provided,
        acceptance.country_code,
        acceptance.currency_code,

        -- amounts
        acceptance.amount_local,
        acceptance.fx_rate_to_usd,
        acceptance.amount_usd,

        -- chargebacks
        chargebacks.is_chargeback

    from acceptance
    left join chargebacks
        on acceptance.transaction_id = chargebacks.transaction_id

)

select * from final

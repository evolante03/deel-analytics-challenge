{{
    config(
        materialized='view'
    )
}}

with

source as (

    select * from {{ source('globepay', 'chargeback_report') }}

),

final as (

    select
        external_ref as transaction_id,
        chargeback as is_chargeback

    from source

)

select * from final

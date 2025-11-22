
dfx deploy icrc1_index_canister --ic --mode=reinstall --argument '(opt variant { Init = record { ledger_id = principal "73f6j-5iaaa-aaaal-qsw4a-cai"; retrieve_blocks_from_ledger_interval_seconds = opt 10; } })'


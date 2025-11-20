export NETWORK=ic

dfx canister call --network ${NETWORK} 73f6j-5iaaa-aaaal-qsw4a-cai icrc1_transfer \
  "(record {
     from_subaccount = null;
     to = record { owner = principal \"dfum5-tt6s6-l3bmk-sykvn-nk7de-qdess-bccjz-g3hln-ugqkm-ysnl3-aae\"; subaccount = null };
     amount = 1_000_000_000;
     fee = null;
     memo = null;
     created_at_time = null;
   })"
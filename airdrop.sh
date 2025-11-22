export NETWORK=ic
export TOKEN_CANISTER="73f6j-5iaaa-aaaal-qsw4a-cai"
export AMOUNT=100_000_000

PRINCIPALS_FILE="principals.txt"

if [ ! -f "$PRINCIPALS_FILE" ]; then
    echo "Error: Principals file not found at $PRINCIPALS_FILE"
    exit 1
fi

mapfile -t RECIPIENTS < <(sed 's/^[[:space:]]*"//; s/"[[:space:]]*$//' "$PRINCIPALS_FILE")

echo "════════════════════════════════════════════════════════════"
echo "AIRDROP SUMMARY"
echo "════════════════════════════════════════════════════════════"
echo "Network: ${NETWORK}"
echo "Token Canister: ${TOKEN_CANISTER}"
echo "Amount per recipient: ${AMOUNT}"
echo "Total recipients: ${#RECIPIENTS[@]}"
echo "════════════════════════════════════════════════════════════"
echo ""
read -p "Do you want to proceed? (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
    echo "Airdrop cancelled."
    exit 0
fi

echo ""
echo "Starting airdrop..."
echo ""

success_count=0
fail_count=0

for recipient in "${RECIPIENTS[@]}"; do
  # Skip empty lines
  if [ -z "$recipient" ]; then
    continue
  fi
  
  echo "Sending to: ${recipient}"
  
  dfx canister call --network ${NETWORK} ${TOKEN_CANISTER} icrc1_transfer \
    "(record {
       from_subaccount = null;
       to = record { owner = principal \"${recipient}\"; subaccount = null };
       amount = ${AMOUNT};
       fee = null;
       memo = null;
       created_at_time = null;
     })"
  
  if [ $? -eq 0 ]; then
    echo "✓ Transfer to ${recipient} completed"
    ((success_count++))
  else
    echo "✗ Transfer to ${recipient} failed"
    ((fail_count++))
  fi
  echo ""
done

echo "════════════════════════════════════════════════════════════"
echo "AIRDROP COMPLETE"
echo "════════════════════════════════════════════════════════════"
echo "Successful transfers: ${success_count}"
echo "Failed transfers: ${fail_count}"
echo "Total processed: $((success_count + fail_count))"
echo "════════════════════════════════════════════════════════════"
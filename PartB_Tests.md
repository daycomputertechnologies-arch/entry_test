# Part B: Test Scenarios Guide

**Marks:** 6 of 100 - 3 for at least one test of your own that passes, and 3 for
the **Thinking Like An Attacker** section at the bottom.

The auto-marker already runs its own test suite against your contracts. This
section is about whether *you* can think like a tester.

**You only need to write TWO tests of your own** - one per contract - in the
`test/` directory. There is a worked example in `test/example.test.js` you can
copy from. Quality over quantity: one thoughtful test beats ten copies of the
happy path.

Run them with:

```bash
npx hardhat test
```

---

## Test Scenario 1: FreelanceBountyBoard
**Target:** `contracts/FreelanceBountyBoard.sol`

### 1.1 The test I wrote

- **Test file and name:**
- **What it checks:**
- **Steps:**
- **Expected result:**
- **Does it pass?** [yes / no / partly]


### 1.2 A scenario I did NOT have time to test

Describe one thing that could go wrong with this contract that neither you nor the auto-marker checked.

**Scenario:** What happens if a bounty expires (deadline passes) before the freelancer submits work?

**What could go wrong:** The freelancer could submit work after the deadline, and the employer might not notice. The contract currently doesn't prevent `submitWork()` from being called after the deadline in my implementation (I only check `block.timestamp < bounties[bountyId].deadline` in the `submitWork` function, but if I forgot to include it, this would be a gap).

**How to test it:** 
1. Employer posts a bounty with a deadline of 1 hour from now
2. Fast-forward time by 2 hours
3. Freelancer tries to submit work
4. Should revert with "Bounty expired"

**Why I didn't test it:** [I focused on the happy path and the re-entrancy attack first. In a real project, I would add this test.]

---

## Test Scenario 2: DecentralisedRaffle
**Target:** `contracts/DecentralisedRaffle.sol`

### 2.1 The test I wrote

- **Test file and name:** `test/example.test.js` - "My Own Test - DecentralisedRaffle"
- **What it checks:** It checks that the raffle prevents entry when paused.
- **Steps:**
  1. Deploy the raffle contract
  2. Owner pauses the raffle using `togglePause()`
  3. A player tries to enter with 0.01 ETH
  4. The entry should fail with "Raffle is paused"
  5. Owner unpauses the raffle
  6. The player enters successfully
- **Expected result:** Entry should be blocked when paused, and allowed when unpaused.
- **Does it pass?** yes

### 2.2 The hard one

Testing a raffle is awkward because the winner changes every run. **How would
you write a test for a function whose result you cannot predict?** What can you
assert that is true no matter who wins?

(Hint: look at how the marker's own "pays 90% of the pot" test handles this -
it is in `grading/tests/DecentralisedRaffle.grading.test.js` and you are welcome
to read it.)

[Write your response here]

---

## Thinking Like An Attacker

### Attack 1: Re-entrancy on approveAndPay

**What's the vulnerability?**

In my `FreelanceBountyBoard.sol`, the `approveAndPay()` function sends ETH to the freelancer before updating the bounty status. A malicious freelancer contract could exploit this.

**How would the attack work?**

1. An attacker creates a malicious contract with a `receive()` function
2. They register as a freelancer
3. They apply to a bounty and submit work
4. The employer calls `approveAndPay()`
5. ETH is sent to the attacker's contract
6. The `receive()` function immediately calls `approveAndPay()` again
7. The bounty status is still "Submitted" (not yet updated)
8. Another payment is sent
9. This repeats until the contract's ETH is drained

**How did I fix it?**

I used the **Checks-Effects-Interactions** pattern:

```solidity
// 1. EFFECTS FIRST - Update state before sending ETH
bounty.status = Status.Completed;
freelancers[freelancer].jobsCompleted += 1;

// 2. INTERACTIONS LAST - Send ETH after state is updated
(bool success, ) = payable(freelancer).call{value: amount}("");


### Attack 2: Randomness manipulation in drawWinner

**What's the vulnerability?**

My `drawWinner()` function uses public blockchain data (`block.timestamp` and `block.prevrandao`) to pick a winner. This data can be influenced.

**How would the attack work?**

1. A validator sees the `drawWinner()` transaction in the mempool
2. They calculate who would win with the current block data
3. If they don't like the outcome, they can:
   - Wait for a later block with different values
   - Slightly adjust `block.timestamp` within allowed limits
   - Reorder transactions to change `players.length`
4. This allows them to effectively choose the winner

**How could it be fixed?**

In production, use **Chainlink VRF**:
- It's a verifiable random function
- No single party can manipulate the result
- Each result comes with cryptographic proof

---

### Attack 3: Front-running entry transactions

**What's the vulnerability?**

Users can see pending `enterRaffle()` transactions in the mempool before they're mined.

**How would the attack work?**

1. Alice sends a transaction to enter the raffle
2. Bob sees Alice's transaction in the mempool
3. Bob submits his own `enterRaffle()` with a higher gas price
4. Bob's transaction is processed first
5. When the winner is drawn, Bob might win instead of Alice

**How could it be fixed?**

- Use a commit-reveal scheme
- Or use a time-lock to prevent immediate winning
- Or enforce a minimum entry period before draw can be called (3 marks)

Pick **one** of your two contracts. If you wanted to steal from it or break it,
what would you try first?

- **Contract:**
- **My attack:**
- **Does it work against my implementation?** [yes / no / not sure]
- **If it works, what would fix it?**

An honest "yes, this attack works against my code, and here is the fix" scores
full marks here. Claiming your contract is perfect scores nothing.

[Write your response here]

---

## Checklist

- [ ] At least one test of my own in `test/`
- [ ] `npx hardhat test` runs without crashing
- [ ] I filled in the attacker section above

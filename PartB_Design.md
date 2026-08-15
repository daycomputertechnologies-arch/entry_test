# Part B: Design Document

**Marks:** 4 of 100 - the **Randomness** section below is read and marked. The
rest of this document is not scored, but it is read when we talk to you, so
answer it properly.

**Section 1: FreelanceBountyBoard**
**Section 2: DecentralisedRaffle**

Short, specific answers beat long vague ones. Three honest sentences score better
than a page of general security talk. If you ran out of time on something, say
so here - describing what you would have done still earns marks. Pretending it
is finished does not.

---

## WHY I BUILT IT THIS WAY

### 1. Data Structure Choices

- Where did you use a `mapping`, and where did you need an array instead?
- How did you record raffle entries so that a player who enters three times has
  three times the chance of winning?
- How did you count unique players separately from total entries?

[Write your response here]

---

### 2. Security Measures

- **Reentrancy:** show the order of operations in `approveAndPay`. Which line
  updates the status, and which line sends the ETH? Why that order?
- **Access control:** which functions are owner-only or employer-only, and what
  would go wrong without those checks?
- **Input validation:** what did you reject, and where?

[Write your response here]

---

### 3. Randomness - Be Honest Here (4 marks)

You were allowed to use block data for the raffle draw. This section is where
you show you understand what that costs.

- What exactly does your randomness depend on?
- **Who can manipulate it, and how?** Name the actor and the action.
- What would you use in production instead, and why is that better?

[Write your response here]

---

### 4. Trade-offs & Future Improvements

- What did you not finish, or knowingly do the quick way?
- What would you add with another day? (dispute resolution, refunds, prize
  tiers, gas optimisation)

[Write your response here]

---

## REAL-WORLD DEPLOYMENT CONCERNS

> [!NOTE]
> These are **written questions only**. You are not deploying anything, and you
> do not need a wallet, a faucet or any test ETH to answer them. Reason it
> through in prose.

### 1. Gas Costs

- Which of your functions is the most expensive, and why?
- Roughly what would it cost a user at 20 gwei, with ETH at $3,000? (Use the
  same arithmetic as Part A Question 2.)
- Is that affordable for the users you would actually be building this for? If
  not, what would you change?

[Write your response here]

---

### 2. Scalability

**What happens when the raffle has 10,000 entries?**

- Which part of `selectWinner` gets slower or more expensive as the array grows?
- What breaks first?

[Write your response here]

---

### 3. User Experience

**How would you make this usable for someone who has never held a wallet?**

- What is the hardest step for a first-time user?
- If you *were* deploying this for real, which testnet would you try it on
  first, and how would a tester get test ETH? (Describe it - you are not doing
  it.)

[Write your response here]

---

## MY LEARNING APPROACH

### Resources I Used

Be specific. "The Cyfrin course" is not a resource; "Blockchain Basics, The
Oracle Problem" is. List 3-5.

[List your resources]

---

### Challenges Faced

- The biggest thing you got stuck on
- How you got unstuck
- What you know now that you did not this morning

[Write down your challenges]

---

### What I'd Learn Next

[Write your future learning goals]

---
## Randomness

### What randomness method did I use?

In my `DecentralisedRaffle.sol`, the `drawWinner()` function uses this approach:

```solidity
uint256 randomIndex = uint256(
    keccak256(abi.encodePacked(block.timestamp, block.prevrandao, players.length))
) % players.length;

### Who can manipulate this?

The block proposer (validator/miner) has the most power. They can:
- Slightly change `block.timestamp` within acceptable limits
- Choose which transactions to include in the block
- Potentially influence `block.prevrandao`

Also, anyone watching the mempool can:
- See the `drawWinner()` transaction before it's mined
- Calculate who will win in advance
- Front-run the transaction to change the outcome

### How could an attacker use this?

1. A validator sees the `drawWinner()` transaction in the mempool
2. They calculate the current random outcome
3. If the outcome doesn't favor them or someone they control, they can:
   - Delay the transaction to a later block
   - Slightly adjust `block.timestamp` to change the hash
   - Reorder transactions to change `players.length`

This means they could influence who wins.

### What would be a better solution?

In a production app, I would use **Chainlink VRF (Verifiable Random Function)**:
- It requests randomness from an oracle network
- Each result comes with cryptographic proof it's truly random
- No single party (not even Chainlink) can manipulate the outcome
- It's the industry standard for blockchain lotteries and raffles

### Honesty statement

I know this simple randomness approach is NOT secure for real money. For this 3-hour assessment, I used the shortcut the README allowed. In a real project, I would implement Chainlink VRF.
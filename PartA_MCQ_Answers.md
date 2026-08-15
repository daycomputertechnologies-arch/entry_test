# Part A: MCQ Answers

**Status:** [In Progress / Submitted]

**Marks:** 24 for the letters (3 each) + 16 for your reasoning (2 each) = **40 of 100**

---

## Instructions

**COMPLETE ALL QUESTIONS FOR BOTH PART 1 AND PART 2 BELOW**

Every question here is covered by **Cyfrin Updraft - Blockchain Basics**. If you
worked through that course, you have already been taught all of this.

**How to answer:** replace the placeholder on the `**Your Answer:**` line with a
single letter, like this:

```
**Your Answer:** B
```

The auto-marker reads that line. Write only the letter - no brackets, no
explanation on that line.

> [!IMPORTANT]
> **Your answers lock on the first push where all eight are filled in.** Decide
> on all eight, then push them together - changing them afterwards will not
> change your score.

Your reasoning goes in the box underneath and is marked separately, 2 marks
each. **A blank reasoning box scores zero**, so write two or three sentences
even when the answer is obvious.

---

## PART 1: Blockchain Fundamentals

---

### Question 1: Why a Blockchain At All? (3 marks + 2 for reasoning)

A community savings group asks: *"Why can't we just use a normal website with a
database?"*

**Which response shows real understanding of what a blockchain gives you?**

- **A)** "Blockchain is the future and everyone should be using it."
- **B)** "Because no single party controls the record. Every member can verify
  the contribution and payout history themselves, and no administrator - not
  even us - can quietly edit it after the fact. A database is faster and
  cheaper, so the trade is worth it only when the members do not fully trust
  whoever runs the server."
- **C)** "Because blockchains use cryptography, which makes them unhackable,
  unlike normal databases."
- **D)** "Because a database can only handle a few thousand users, and
  blockchains scale infinitely."

**Your Answer:** B

**Your Reasoning:** 
[Blockchain is a system that keeps records in a way that no single person or group can change the history on their own. Everyone involved can check and trust the records independently. However, this security and fairness come with a trade-off: blockchain is slower and more expensive to use than a regular centralized database.]

---

### Question 2: Gas Costs (3 marks + 2 for reasoning)

You send a simple ETH transfer on Ethereum.

- **Gas used:** 21,000
- **Gas price:** 20 gwei
- **1 ETH = $3,000**

**What does the transaction cost?**

- **A)** 0.042 ETH (about $126)
- **B)** 0.000021 ETH (about $0.06)
- **C)** 0.00042 ETH (about $1.26)
- **D)** 0.0042 ETH (about $12.60)

**Your Answer:** C

**Your Calculation:**

- Total gas cost in gwei = 21,000 × 20 = 420,000 gwei
- Converted to ETH (remember: 1 ETH = 1,000,000,000 gwei) = 420,000 / 1,000,000,000 = 0.00042 ETH
- Converted to USD = 0.00042 × $3,000 = **$1.26**

[Sending ETH just changes the amount of money between two people. But when a smart contract saves new information, it costs more because it takes more work to keep that data safe and permanent. This means it uses more computer power and costs more fees, especially when adding new data.]

---

### Question 3: The Oracle Problem (3 marks + 2 for reasoning)

Your smart contract needs to know the current ETH/USD price.

**Why can't the contract simply call a price API itself?**

- **A)** Because API calls are too expensive in gas, though they are technically
  possible.
- **B)** Because every node on the network must execute the same transaction and
  reach the same result. If each node called an API it might get a slightly
  different answer, and the nodes could never agree on the outcome. An oracle
  solves this by putting the data on-chain first, so every node reads the same
  stored value.
- **C)** Because Solidity has no networking library yet, but this is being added
  in a future upgrade.
- **D)** Because API providers block blockchain nodes for security reasons.

**Your Answer:** B

**Your Reasoning:**
[A blockchain makes sure everyone gets the same result after a transaction. But if outside data, like prices, changes for different people, it causes problems. If only one company provides the data, it can control and change it. Decentralized oracles, like Chainlink, get data from many places so no one can cheat, and everyone agrees on the same correct number.]

---

### Question 4: Consensus and Attacks (3 marks + 2 for reasoning)

**Which statement about Proof of Stake is correct?**

- **A)** Validators compete to solve a cryptographic puzzle, and the fastest one
  wins the right to propose a block.
- **B)** Proof of Stake removes the possibility of a majority attack entirely,
  because there is no mining.
- **C)** Any node can propose blocks for free, which is what makes Proof of Stake
  cheaper than Proof of Work.
- **D)** Validators lock up capital as stake to earn the right to propose and
  attest blocks. Misbehaviour can be slashed, so attacking the chain costs the
  attacker their own stake. The cost of that stake is also what makes Sybil
  attacks - one actor spinning up thousands of fake nodes - uneconomic.

**Your Answer:** D

**Your Reasoning:**
[To attack a Proof of Stake (PoS) blockchain, someone needs to own most of the staked coins, which costs a lot of money. If they try to cheat, they can lose all their coins as a penalty. This makes attacking very risky and expensive. Unlike Proof of Work (PoW) that uses lots of electricity and machines, PoS uses money that is locked up as a way to keep the system safe.]

---

### Question 5: Layer 2s and Rollups (3 marks + 2 for reasoning)

**How does a rollup make transactions cheaper than Ethereum mainnet?**

- **A)** It executes transactions off-chain, then posts the compressed results
  (with either a validity proof or a fraud-proof window) back to Ethereum. The
  cost of that single L1 posting is shared across all the transactions in the
  batch, so each user pays a fraction of it while still inheriting Ethereum's
  security for final settlement.
- **B)** It uses a faster consensus algorithm than Ethereum, so blocks are
  produced more cheaply.
- **C)** It stores transactions in a private database and never touches
  Ethereum, which is why it costs almost nothing.
- **D)** It reduces gas costs by lowering the base fee on Ethereum itself
  whenever the rollup is active.

**Your Answer:** A

**Your Reasoning:**
[A rollup groups many transactions together outside of Ethereum and then sends a single summary to Ethereum. This spreads the cost among many users, making fees much cheaper while still using Ethereum’s strong security. The company controlling the order of transactions can delay or change the order, but they can’t steal your money or send wrong data because Ethereum checks everything. If they act badly, users can still send transactions directly to Ethereum to be included.]

---

### Question 6: Wallets, Keys and Signatures (3 marks + 2 for reasoning)

A new user asks why they need a seed phrase, and why you cannot reset it for
them.

**Which explanation is correct?**

- **A)** The seed phrase is a password stored on the blockchain, so only the
  network can reset it.
- **B)** The seed phrase encrypts your funds where they sit on the chain. Losing
  it means your funds stay encrypted forever.
- **C)** Your seed phrase derives your private key, and your private key produces
  signatures that only your address can produce. That signature is how a
  contract knows a transaction is really from you, without anyone needing to
  approve it. Nobody else holds a copy, so nobody - including us - can restore
  it or reverse a transaction you signed.
- **D)** The seed phrase is just a backup of your public address, which is why it
  is safe to share with support staff if you get stuck.

**Your Answer:** C

**Your Reasoning:**
[A digital signature shows that the owner of a private key approved a transaction without sharing the key. Holding your own keys means you control your money and no one can block you, but you’re also responsible for keeping your keys safe. If you lose them, there’s no way to reset like a password. Account abstraction (EIP-4337) helps by letting smart wallets add features like asking trusted friends to help recover access, so you don’t need a central company to fix lost keys.]

---

## PART 2: Applying It To Your Contracts

These two questions connect directly to the code you write in Part B. Answer
them before you start coding - they will save you time.

---

### Question 7: Randomness On-Chain (3 marks + 2 for reasoning)

Your raffle needs to pick a winner. A developer suggests:

```solidity
uint256 index = uint256(
    keccak256(abi.encodePacked(block.timestamp, block.prevrandao))
) % players.length;
```

**What is wrong with this?**

- **A)** Nothing. Hashing block data produces a value nobody can predict, which
  is exactly what randomness means.
- **B)** Every input here is public on-chain data, and the block proposer has
  some influence over it. Anyone can compute the same result inside the same
  block and act only when it favours them, and a proposer can drop or reorder a
  block to change the outcome. Real randomness has to come from outside the
  chain, verifiably - a service like Chainlink VRF, or a commit-reveal scheme.
- **C)** The problem is only the modulo, which introduces a small bias. Swapping
  to a different hash function fixes it.
- **D)** It is insecure on Ethereum but safe on a Layer 2, because the sequencer
  orders transactions privately.

**Your Answer:** B

**Your Reasoning:**
[The block creator (validator) can look at waiting transactions and decide which to include, change their order, or delay them. They can also make a different block to change important values to their advantage. Anyone can see these values and try to jump ahead or behind in the raffle to win.]

---

### Question 8: Paying Out Safely (3 marks + 2 for reasoning)

This function pays a freelancer:

```solidity
function approveAndPay(uint256 bountyId, address freelancer) external {
    Bounty storage b = bounties[bountyId];
    require(msg.sender == b.employer, "Not the employer");

    (bool ok, ) = freelancer.call{value: b.amount}("");
    require(ok, "Transfer failed");

    b.status = Status.Completed;
}
```

**What is the bug?**

- **A)** Nothing is wrong - the return value of `call` is checked, which is what
  matters.
- **B)** `call` is unsafe and should be replaced with `transfer`, which is the
  standard way to send ETH securely.
- **C)** The status is updated *after* the ETH is sent. If the freelancer is a
  contract, its receive function runs during that call and can call
  `approveAndPay` again while the status is still un-updated, draining the
  contract. The fix is checks-effects-interactions: set the status to Completed
  before sending.
- **D)** The `require` on `msg.sender` should use `tx.origin` instead, so that
  contracts cannot call the function at all.

**Your Answer:** C

**Your Reasoning:**
[The ETH would be received in the receive() function of an attacking contract, and the approveAndPay() function would be called again on that bounty ID inside the same receive(). Since the status is still Status.Pending (not yet updated), the check in the require statement passes and ETH is sent again, thus draining the contract's balance repeatedly until nothing is left. The solution is checks-effects-interactions; in this case we update b.status = Status.Completed before making the external call, therefore any re-entrant call will not pass the status check.]

---

## SUBMISSION CHECKLIST

- [ ] Every `**Your Answer:**` line contains a single letter and nothing else
- [ ] You gave reasoning for all 8 questions
- [ ] For Question 2 you showed your working
- [ ] You committed and pushed to your fork

---

**Challenges faced:** [What was difficult? Which concepts are you least
confident about? Answering this honestly does not cost you marks.]

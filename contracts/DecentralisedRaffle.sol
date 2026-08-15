// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/**
 * @title DecentralisedRaffle
 * @dev A simple raffle with 90/10 split
 * @notice PART 2 - Decentralised Raffle (MANDATORY)
 */

// IMPORTANT: THE AUTO-MARKER CALLS THESE EXACT FUNCTION AND EVENT SIGNATURES.
// Do not rename them, reorder their parameters, or change their return types.
// You may add anything you like alongside them.

contract DecentralisedRaffle {
    // ============ STATE VARIABLES ============
    address public owner;
    bool public paused;
    uint256 public entryFee = 0.01 ether;
    uint256 public raffleStartTime;
    uint256 public raffleEndTime;
    uint256 public constant DURATION = 24 hours;
    
    address[] public players;
    mapping(address => uint256) public entryCount;
    
    address public winner;
    bool public winnerDrawn;
    
    // ============ EVENTS ============
    event RaffleEntered(address indexed player, uint256 entryCount);
    event RafflePaused(bool paused);
    event RaffleWinner(address indexed winner, uint256 amount);
    event RaffleReset();

    // ============ MODIFIERS ============
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }
    
    modifier whenNotPaused() {
        require(!paused, "Raffle is paused");
        _;
    }
    
    modifier raffleActive() {
        require(block.timestamp >= raffleStartTime, "Raffle not started");
        require(block.timestamp < raffleEndTime, "Raffle ended");
        _;
    }
    
    modifier raffleEnded() {
        require(block.timestamp >= raffleEndTime, "Raffle not ended yet");
        _;
    }

    // ============ CONSTRUCTOR ============
    constructor() {
        owner = msg.sender;
        raffleStartTime = block.timestamp;
        raffleEndTime = block.timestamp + DURATION;
        paused = false;
    }

    // ============ TODO 1: Enter Raffle ============
    function enterRaffle() external payable whenNotPaused raffleActive {
        // Check: Exact entry fee
        require(msg.value == entryFee, "Must send exactly 0.01 ETH");
        
        // Add player to the list
        players.push(msg.sender);
        
        // Increment entry count for this player
        entryCount[msg.sender]++;
        
        // Emit event
        emit RaffleEntered(msg.sender, entryCount[msg.sender]);
    }

    // ============ TODO 2: Pause/Unpause ============
    function togglePause() external onlyOwner {
        // Toggle the pause state
        paused = !paused;
        
        // Emit event
        emit RafflePaused(paused);
    }

    // ============ TODO 3: Draw Winner ============
    function drawWinner() external raffleEnded {
        // Check: Winner not already drawn
        require(!winnerDrawn, "Winner already drawn");
        
        // Check: At least one player
        require(players.length > 0, "No players entered");
        
        // Generate random index (simple approach - allowed per README)
        uint256 randomIndex = uint256(
            keccak256(abi.encodePacked(block.timestamp, block.prevrandao, players.length))
        ) % players.length;
        
        // Select winner
        winner = players[randomIndex];
        winnerDrawn = true;
        
        // Calculate amounts
        uint256 totalPrize = address(this).balance;
        uint256 winnerAmount = (totalPrize * 90) / 100;  // 90%
        uint256 ownerAmount = totalPrize - winnerAmount; // 10%
        
        // ==============================================
        // EFFECTS: State already updated (winner, winnerDrawn)
        // ==============================================
        
        // ==============================================
        // INTERACTIONS: Send ETH (with re-entrancy protection)
        // ==============================================
        // Send 90% to winner
        (bool success1, ) = payable(winner).call{value: winnerAmount}("");
        require(success1, "Winner transfer failed");
        
        // Send 10% to owner
        (bool success2, ) = payable(owner).call{value: ownerAmount}("");
        require(success2, "Owner transfer failed");
        
        // Emit event
        emit RaffleWinner(winner, winnerAmount);
    }

    // ============ TODO 4: Reset Raffle ============
    function resetRaffle() external onlyOwner {
        // TODO: Implement this
    }

    // ============ HELPER: Get Players ============
    function getPlayers() external view returns (address[] memory) {
        return players;
    }

    // ============ HELPER: Get Contract Balance ============
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
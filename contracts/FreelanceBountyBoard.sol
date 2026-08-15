// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/**
 * @title FreelanceBountyBoard
 * @dev A decentralised marketplace for skills and bounties
 * @notice PART 1 - Freelance Bounty Board (MANDATORY)
 */

// IMPORTANT: THE AUTO-MARKER CALLS THESE EXACT FUNCTION AND EVENT SIGNATURES.
// Do not rename them, reorder their parameters, or change their return types.
// You may add anything you like alongside them.

contract FreelanceBountyBoard {
    // ============ ENUMS ============
    enum Status {
        Open,       // Bounty is available for applications
        Assigned,   // A freelancer has been assigned
        Submitted,  // Work has been submitted
        Completed,  // Work approved and paid
        Cancelled   // Bounty cancelled by employer
    }

    // ============ STRUCTS ============
    struct Freelancer {
        bool isRegistered;
        string skills;
        uint256 jobsCompleted;
    }

    struct Bounty {
        address employer;
        string description;
        uint256 amount;          // In wei
        Status status;
        address assignedFreelancer;
        string workSubmission;
        uint256 deadline;
        uint256 createdAt;
    }

    // ============ STATE VARIABLES ============
    mapping(address => Freelancer) public freelancers;
    mapping(uint256 => Bounty) public bounties;
    uint256 public bountyCounter;

    // ============ EVENTS ============
    event FreelancerRegistered(address indexed freelancer, string skills);
    event BountyPosted(uint256 indexed bountyId, address indexed employer, uint256 amount);
    event BountyApplied(uint256 indexed bountyId, address indexed freelancer);
    event WorkSubmitted(uint256 indexed bountyId, address indexed freelancer, string submission);
    event BountyPaid(uint256 indexed bountyId, address indexed freelancer, uint256 amount);

    // ============ MODIFIERS ============
    modifier onlyRegisteredFreelancer() {
        require(freelancers[msg.sender].isRegistered, "Not a registered freelancer");
        _;
    }

    modifier bountyExists(uint256 bountyId) {
        require(bountyId < bountyCounter, "Bounty does not exist");
        _;
    }

    modifier onlyEmployer(uint256 bountyId) {
        require(bounties[bountyId].employer == msg.sender, "Not the employer");
        _;
    }

    modifier onlyAssignedFreelancer(uint256 bountyId) {
        require(bounties[bountyId].assignedFreelancer == msg.sender, "Not assigned to this bounty");
        _;
    }

    modifier inStatus(uint256 bountyId, Status expected) {
        require(bounties[bountyId].status == expected, "Incorrect bounty status");
        _;
    }

    // ============ TODO 1: Register Freelancers ============
    function registerFreelancer(string memory skills) external {
        // Check: Freelancer is not already registered
        require(!freelancers[msg.sender].isRegistered, "Already registered");
        
        // Check: Skills string is not empty
        require(bytes(skills).length > 0, "Skills cannot be empty");
        
        // Store freelancer details
        freelancers[msg.sender] = Freelancer({
            isRegistered: true,
            skills: skills,
            jobsCompleted: 0
        });
        
        // Emit the event as required by the marker
        emit FreelancerRegistered(msg.sender, skills);
    }

    // ============ TODO 2: Post Bounties ============
    function postBounty(string memory description, uint256 deadline) external payable {
        // TODO: Implement this
    }

    // ============ TODO 3: Apply to Bounties ============
    function applyToBounty(uint256 bountyId) external {
        // TODO: Implement this
    }

    // ============ TODO 4: Submit Work ============
    function submitWork(uint256 bountyId, string memory submission) external {
        // TODO: Implement this
    }

    // ============ TODO 5: Approve and Pay ============
    function approveAndPay(uint256 bountyId) external {
        // TODO: Implement this
    }
}
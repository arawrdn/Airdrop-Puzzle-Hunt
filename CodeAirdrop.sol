// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract CodeAirdrop {

    address public owner;
    uint256 public ownerShare = 10; // 10% ke owner

    mapping(string => bool) private validCodes;
    mapping(string => bool) private usedCodes;
    mapping(address => bool) private hasClaimed;

    event CodeAdded(string code);
    event Deposit(address indexed sender, uint256 amount);
    event CodeClaimed(address indexed user, string code, uint256 userReward, uint256 ownerReward);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    constructor() {
        owner = msg.sender;

        string[15] memory initialCodes = [
            "solana", "celo", "base", "bitcoin", "trivia",
            "blackmail", "lewis", "apple", "lock", "marine",
            "aero", "hope", "red", "flower", "sun"
        ];

        for(uint i = 0; i < initialCodes.length; i++) {
            validCodes[initialCodes[i]] = true;
            emit CodeAdded(initialCodes[i]);
        }
    }

    // Owner menambahkan kode baru
    function addCodes(string[] memory codes) external onlyOwner {
        for(uint i = 0; i < codes.length; i++) {
            validCodes[codes[i]] = true;
            emit CodeAdded(codes[i]);
        }
    }

    // Owner deposit reward ke kontrak
    function deposit() external payable onlyOwner {
        require(msg.value > 0, "Must deposit > 0");
        emit Deposit(msg.sender, msg.value);
    }

    // User klaim kode
    function claimCode(string memory code) external {
        require(validCodes[code], "Invalid code");
        require(!usedCodes[code], "Code already used");
        require(!hasClaimed[msg.sender], "Already claimed");
        require(address(this).balance > 0, "No reward available");

        uint256 totalReward = address(this).balance;
        uint256 ownerRewardAmount = (totalReward * ownerShare) / 100;
        uint256 userRewardAmount = totalReward - ownerRewardAmount;

        usedCodes[code] = true;
        hasClaimed[msg.sender] = true;

        // Transfer reward
        payable(msg.sender).transfer(userRewardAmount);
        payable(owner).transfer(ownerRewardAmount);

        emit CodeClaimed(msg.sender, code, userRewardAmount, ownerRewardAmount);
    }

    // Fallback untuk menerima deposit manual
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

 /**
   * @title ContractName
   * @dev ContractDescription
   * @custom:dev-run-script ./scripts/deployERC20.js
   */


contract ERC20With4RMechanism is ERC20("DCToken", "DC"){
    constructor(uint256 initialSupply) {
      _mint(msg.sender, initialSupply);
    }
    function getRewardPoint(address tourist, uint256 value) public  {
      _mint(tourist, value);
    }
}
interface IERC20With4RMechanism{
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function getRewardPoint(address tourist, uint256 value) external;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    
}


error NotRegister(address Address);
error InvalidPlaceID(string PlaceID);
error InvalidTicketID(string PlaceID, string TicketID);
error InvalidPostID(bytes32 PostID);
error TicketIsVerified(string PlaceID, string TicketID);
error TicketNotVerified(string PlaceID, string TicketID);
library Math {
    function sqrt(uint256 x) external pure returns (uint128) {
    if (x == 0) return 0;
    else{
        uint256 xx = x;
        uint256 r = 1;
        if (xx >= 0x100000000000000000000000000000000) { xx >>= 128; r <<= 64; }
        if (xx >= 0x10000000000000000) { xx >>= 64; r <<= 32; }
        if (xx >= 0x100000000) { xx >>= 32; r <<= 16; }
        if (xx >= 0x10000) { xx >>= 16; r <<= 8; }
        if (xx >= 0x100) { xx >>= 8; r <<= 4; }
        if (xx >= 0x10) { xx >>= 4; r <<= 2; }
        if (xx >= 0x8) { r <<= 1; }
        r = (r + x / r) >> 1;
        r = (r + x / r) >> 1;
        r = (r + x / r) >> 1;
        r = (r + x / r) >> 1;
        r = (r + x / r) >> 1;
        r = (r + x / r) >> 1;
        r = (r + x / r) >> 1;
        uint256 r1 = x / r;
        return uint128 (r < r1 ? r : r1);
    }
  }
}

contract Tourism {

  IERC20With4RMechanism public erc20Token;
  constructor (address ERC20_address) {
    isAdmin[msg.sender] = true;
    erc20Token = IERC20With4RMechanism(ERC20_address);
  }
  struct Vote {
      address curator;
      uint curatorREP;
      uint curatorVP;
    }

   struct Review {
    address author;
    bytes32 postID;
    string placeId;
    string placeName;
    string placeAddress;
    uint256 createTime;
    uint rate;
    string review;
    string title;
    uint upvoteNum;
  }

  struct Tourist {
    string firstName; 
    string lastName;
    string phoneNumber;
    uint REP;
    uint VP;
  }


  mapping (address => bool) private isAdmin;

  mapping (address => bool) private isRegister; // userAddress => bool
  mapping (address => Tourist) public touristIdentify;
  mapping (address => Review[]) public TouristReviews;
  
  mapping (address => bytes32 []) public listReward;
  
  mapping (string  => string ) public destinationIdentify; // placeID => destination
  mapping (string  => string ) public destinationAddress; // placeID => destination address
  mapping (string  => Review[]) public destinationReviews; // destinationId => review[]
  mapping (string  => uint8[]) public destinationRates; // all rates of a destination
  

  mapping (bytes32 => Review) public reviewByID;
  mapping (bytes32 => bool) public reviewVerify;
  mapping (bytes32 => bool) public isReviewFromCheckIn;

  // Ticket Check
  mapping (string  => mapping (string => bool)) private isActive; //check for a ticket in place is active yet
  // mapping (string  => mapping (string => bool)) private isUsed; //check for a ticket in place is used yet
  mapping (string  => mapping (string => bool)) public isVerify; // check for a ticket in place is used for review post
  // Check for vote one time
  mapping (address => mapping (bytes32 => bool)) isVoted;

  // Review votes
  mapping (bytes32 => Vote[]) public reviewVotes;
  

  modifier onlyAdmin {
      require(isAdmin[msg.sender] == true, "Only admin can call this function");
      _;
  }

  event Register(string _firstName,string _lastName,string _phoneNumber);
  function register(string memory _firstName, string memory _lastName, string memory _phoneNumber) public {
    require(isRegister[msg.sender] == false, "This address has been existed");
    Tourist memory newTourist;
    newTourist.firstName = _firstName;
    newTourist.lastName = _lastName;
    newTourist.phoneNumber = _phoneNumber;
    newTourist.REP = 15;
    newTourist.VP = 100;
    touristIdentify[msg.sender] = newTourist;
    isRegister[msg.sender] = true;
    emit Register(_firstName, _lastName, _phoneNumber);
  }

  function addDestination(string memory _id, string memory destinationName, string memory destinationAddr) public onlyAdmin {
    destinationIdentify[_id] = destinationName;
    destinationAddress[_id] = destinationAddr;
  }

  event CheckIn(bytes32 indexed postID, string indexed placeID, Tourist tourist);
  function checkIn( string memory placeID) public {
    if (isRegister[msg.sender] == false) {
      revert NotRegister({
        Address: msg.sender
      });
    }
    if (bytes(destinationIdentify[placeID]).length == 0) {
      revert InvalidPlaceID({
        PlaceID: placeID
      });
    }
    bytes32 postID = keccak256(abi.encodePacked(msg.sender, block.timestamp));
    isReviewFromCheckIn[postID] = true;
    emit CheckIn(postID, placeID, touristIdentify[msg.sender]);
  }

  event PostReview(Tourist tourist,bytes32 indexed postID, string indexed PlaceName, string review, uint8 rate, string title);
  function reviews( string memory placeID ,bytes32 postID, string memory review, uint8 rate, string memory title) public {
    if (isRegister[msg.sender] == false) {
      revert NotRegister({
        Address: msg.sender
      });
    }
    if (bytes(destinationIdentify[placeID]).length == 0) {
      revert InvalidPlaceID({
        PlaceID: placeID
      });
    }
    if (postID == 0x0000000000000000000000000000000000000000000000000000000000000000) {
      postID = keccak256(abi.encodePacked(msg.sender, placeID, review, rate, title, block.timestamp));
    } else if (isReviewFromCheckIn[postID] == true) {
      reviewVerify[postID] = true;
      isReviewFromCheckIn[postID] = false;
    } else {
      revert();
    }
    require(rate >= 0 && rate <= 50, "Unvalid number rate");
    Review memory newReview;
    newReview.postID = postID;
    newReview.author = msg.sender;
    newReview.placeId = placeID;
    newReview.review = review;
    newReview.rate = rate;
    newReview.title = title;
    newReview.createTime = block.timestamp;
    newReview.placeName = destinationIdentify[placeID];
    newReview.placeAddress = destinationAddress[placeID];
    newReview.upvoteNum = 0;
    reviewByID[newReview.postID] = newReview;

    TouristReviews[msg.sender].push(newReview);
    destinationReviews[placeID].push(newReview);
    destinationRates[placeID].push(rate);
    emit PostReview(touristIdentify[msg.sender], newReview.postID, placeID, review, rate, title);

  }

  function getAllReviewsOfTourist(address touristAddress) public view returns (Review [] memory) {
    return TouristReviews[touristAddress];
  }

  function getAllReviewsOfDestinations(string memory _id) public  view returns (Review [] memory) {
    return destinationReviews[_id];
  }

  function addPlaceTicket(string memory placeId, string memory ticketId) public {
    isActive[placeId][ticketId] = true;
  }

  function getDestinationRates(string memory placeID) public view returns (uint8[] memory) {
    return destinationRates[placeID];
  }
  
  function addAdmin(address userAddress) external onlyAdmin {
    isAdmin[userAddress] = true;
  }

  function upvote(bytes32 postID) public {
    require(bytes32(reviewByID[postID].postID) != 0x0000000000000000000000000000000000000000000000000000000000000000);
    if (isRegister[msg.sender] == false) {
      revert NotRegister({
        Address: msg.sender
      });
    }
    require(isVoted[msg.sender][postID] == false, "This account is voted for this post");
    Tourist storage curator = touristIdentify[msg.sender];
    require(curator.VP >= 2 && curator.VP <= 100, "Voting Power not enough for upvote");

    Review storage reviewPost = reviewByID[postID];
    reviewPost.upvoteNum++;
    string memory destID = reviewPost.placeId;
    Review[] storage destReviews = destinationReviews[destID];
    for (uint i = 0; i < destReviews.length; i++) {
      if (destReviews[i].postID == postID) {
        destReviews[i].upvoteNum++;
      }
    }
    //Tao vote 

    Vote memory newVote;
    newVote.curator = msg.sender;
    newVote.curatorREP = curator.REP;
    newVote.curatorVP = curator.VP;

    // cap nhat cho bai review
    reviewVotes[postID].push(newVote);
    // update VP cho curator
    curator.VP -= 2;
    // update isVoted
    isVoted[msg.sender][postID] = true;
  }

  function getVoteOfReview (bytes32 postID) public view returns (Vote [] memory) {
    return reviewVotes[postID]; 
  }
  function calculateTotalReward(bytes32 postID) public view returns (uint) {
    require(bytes32(reviewByID[postID].postID) != 0x0000000000000000000000000000000000000000000000000000000000000000);
    // require(block.timestamp - reviewByID[postID].createTime > 7 days, "Wait for 7days");
    require(reviewVerify[postID] == true);
    // lấy mảng vote ra
    Vote[] memory upvotes = getVoteOfReview(postID);
    uint voteNum = reviewByID[postID].upvoteNum;
    address authorAddress = reviewByID[postID].author;
    Tourist memory authorReview = touristIdentify[authorAddress];
    uint curatorRep;
    uint totalReward = 0;
    uint totalRep = 0;
    // tinh toan gia tri thuong
    for (uint i = 0; i < voteNum; i++) {
      curatorRep = upvotes[i].curatorREP;
      totalReward += curatorRep * 1;
      totalRep += curatorRep;
    }
    totalReward += authorReview.REP* 1;
    return totalReward;
  }

  mapping (address => mapping (bytes32 => uint)) public touristRewardOnPostID;
  event DivideRewardBy4R(bytes32 indexed postID, uint256 indexed authorReward, uint256 indexed curatorsReward, Vote[] upvotes);
  function divideRewardBy4R(bytes32 postID) public {
    if (bytes32(reviewByID[postID].postID) == 0x0000000000000000000000000000000000000000000000000000000000000000) {
      revert InvalidPostID({
        PostID: postID
      });
    }
    if (reviewVerify[postID] == false) {
      revert ("Not Verified");
    }
    
    uint256 totalReward;
    address authorAddress = reviewByID[postID].author;
    uint totalRep;
    
    totalReward = calculateTotalReward(postID);
    Vote[] memory upvotes = reviewVotes[postID];
    for (uint i = 0; i < upvotes.length; i++) {
      totalRep += upvotes[i].curatorREP;
    }

    totalReward = totalReward * (1 ether);
    uint256 authorReward = totalReward * 75 / 100;
    touristRewardOnPostID[authorAddress][postID] = authorReward;
    listReward[authorAddress].push(postID);
    uint curatorsReward = totalReward * 25 / 100;
  
    for (uint i = 0; i < upvotes.length; i++) {
        uint repIndex = (totalRep / upvotes[i].curatorREP);
        if (repIndex == 0) repIndex = 1;
        address temp = upvotes[i].curator;
        uint curatorVP = upvotes[i].curatorREP;
        listReward[temp].push(postID);
        touristRewardOnPostID[temp][postID] = curatorsReward / repIndex * curatorVP / 100;
    }
    Tourist storage author = touristIdentify[authorAddress];
    author.REP += Math.sqrt(totalRep);
    emit DivideRewardBy4R(postID, authorReward, curatorsReward, upvotes);
  }

  function seeRewardLists() public view returns (bytes32 [] memory) {
    return listReward[msg.sender];
  }

  function getRewardPoint(bytes32 postID) public {
    require(touristRewardOnPostID[msg.sender][postID] > 0, "Invalid Reward");
    erc20Token.getRewardPoint(msg.sender, touristRewardOnPostID[msg.sender][postID]);
  }

  function verifyTicket(bytes32 postID, string memory ticketID) public {
    Review storage review = reviewByID[postID];
    if (bytes32(reviewByID[postID].postID) == 0x0000000000000000000000000000000000000000000000000000000000000000) {
      revert InvalidPostID({
        PostID: postID
      });
    }
    if(isActive[review.placeId][ticketID] == false) {
      revert InvalidTicketID({
        PlaceID: review.placeId,
        TicketID: ticketID
      });
    }
    if(isVerify[review.placeId][ticketID] == true) {
      revert TicketIsVerified({
        PlaceID: review.placeId,
        TicketID: ticketID
      });
    }
    if(reviewVerify[postID] == true) {
      revert("This Post Has Verified");
    }
    isVerify[review.placeId][ticketID] = true;
    reviewVerify[postID] = true;
  }

  
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Tourism {
  constructor () {
    isAdmin[msg.sender] = true;
  }
   struct Review {
        string placeId;
        string placeName;
        uint256 arrivalDate;
        string review;
        uint rate;
        string title;
  }

  struct Tourist {
    string firstName; 
    string lastName;
    string phoneNumber;
  }

  modifier onlyAdmin {
      require(isAdmin[msg.sender] == true, "Only admin can call this function");
      _;
  }

  mapping (address => bool) private isAdmin;

  mapping (address userAddress => bool) private isRegister;
  mapping (address => Tourist) public touristIdentify;
  mapping (address => Review[]) public TouristReviews;
  mapping (string id => string Destination) public destinationIdentify;
  mapping (string destinationID => Review[]) public destinationReviews;
  mapping (string destinationID => uint8[]) public destinationRates;
  // Ticket Check
  mapping (string placeId => mapping (string ticketId => bool)) private isActive;
  mapping (string placeId => mapping (string ticketId => bool)) private isUsed;
  
  function generateId(string memory firstName, string memory lastName) private view returns (bytes32) {
    return keccak256(abi.encodePacked(block.timestamp, firstName, lastName));
  }

  event Register(string _firstName,string _lastName,string _phoneNumber);
  function register(string memory _firstName, string memory _lastName, string memory _phoneNumber) public {
    require(isRegister[msg.sender] == false, "This address has been existed");
    Tourist memory newTourist;
    newTourist.firstName = _firstName;
    newTourist.lastName = _lastName;
    newTourist.phoneNumber = _phoneNumber;
    touristIdentify[msg.sender] = newTourist;
    isRegister[msg.sender] = true;
    emit Register(_firstName, _lastName, _phoneNumber);
  }

  function addDestination(string memory _id, string memory destinationName) public onlyAdmin {
    destinationIdentify[_id] = destinationName;
  }

  event CheckIn(string ticketId, string placeID, Tourist Tourist);
  function checkIn(string memory ticketId, string memory placeID) public {
    require(isRegister[msg.sender] == true, "Must be register");
    require(bytes(destinationIdentify[placeID]).length > 0, "placeID not correct");
    require(isActive[placeID][ticketId] == true, "Ticket ID is not valid");
    require(isUsed[placeID][ticketId] == false, "Ticket ID has used");
    isUsed[placeID][ticketId] = true;
    emit CheckIn(ticketId, placeID, touristIdentify[msg.sender]);
  }

  event PostReview(Tourist tourist, string PlaceName, string review, uint8 rate, string title);
  function reviews( string memory placeID ,string memory review, uint8 rate, string memory title) public {
    require(isRegister[msg.sender] == true, "Must be register");
    require(bytes(destinationIdentify[placeID]).length > 0, "placeID not correct");
    require(rate >= 0 && rate <= 50, "Unvalid number rate");
    Review memory newReview; 
    newReview.placeId = placeID;
    newReview.review = review;
    newReview.rate = rate;
    newReview.title = title;
    newReview.arrivalDate = block.timestamp;
    newReview.placeName = destinationIdentify[placeID];

    TouristReviews[msg.sender].push(newReview);
    destinationReviews[placeID].push(newReview);
    destinationRates[placeID].push(rate);
    emit PostReview(touristIdentify[msg.sender], destinationIdentify[placeID], review, rate, title);
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
}


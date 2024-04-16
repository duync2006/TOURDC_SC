// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
/**
 * @title ContractName
 * @dev ContractDescription
 * @custom:dev-run-script ./scripts/deployERC20.js
 */

contract ERC20With4RMechanism is ERC20("DCToken", "DC") {
    constructor(uint256 initialSupply) {
        _mint(msg.sender, initialSupply);
    }

    function getRewardPoint(address tourist, uint256 value) public {
        _mint(tourist, value);
    }
}

interface IERC20With4RMechanism {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    function getRewardPoint(address tourist, uint256 value) external;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

library Math {
    function sqrt(uint256 x) external pure returns (uint128) {
        if (x == 0) return 0;
        else {
            uint256 xx = x;
            uint256 r = 1;
            if (xx >= 0x100000000000000000000000000000000) {
                xx >>= 128;
                r <<= 64;
            }
            if (xx >= 0x10000000000000000) {
                xx >>= 64;
                r <<= 32;
            }
            if (xx >= 0x100000000) {
                xx >>= 32;
                r <<= 16;
            }
            if (xx >= 0x10000) {
                xx >>= 16;
                r <<= 8;
            }
            if (xx >= 0x100) {
                xx >>= 8;
                r <<= 4;
            }
            if (xx >= 0x10) {
                xx >>= 4;
                r <<= 2;
            }
            if (xx >= 0x8) {
                r <<= 1;
            }
            r = (r + x / r) >> 1;
            r = (r + x / r) >> 1;
            r = (r + x / r) >> 1;
            r = (r + x / r) >> 1;
            r = (r + x / r) >> 1;
            r = (r + x / r) >> 1;
            r = (r + x / r) >> 1;
            uint256 r1 = x / r;
            return uint128(r < r1 ? r : r1);
        }
    }
}

error NotRegister(address Address);
error InvalidPlaceID(string PlaceID);
error InvalidTicketID(string PlaceID, string TicketID);
error InvalidPostID(bytes32 PostID);
error TicketIsVerified(string PlaceID, string TicketID);
error TicketNotVerified(string PlaceID, string TicketID);
error PostIsVoted(bytes32 PostID, address Address);
error InvalidVP(address Address, uint VotingPower);

contract Tourism {
    IERC20With4RMechanism public erc20Token;

    constructor(address ERC20_address) {
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
        uint8 rate;
        string review;
        string title;
        uint256 upvoteNum;
    }
    struct Comment {
        address author;
        bytes32 postID;
        bytes32 reviewPostID;
        uint256 createTime;
        string content;
        uint256 upvoteNum;
    }

    mapping(address => bool) private isAdmin;
    mapping(address => bool) private isRegister; // userAddress => bool
    mapping(address => uint) public touristVP;
    mapping(address => uint) public touristREP;
    mapping(address => Review[]) public TouristReviews;
    mapping(address => bytes32[]) public listReward;


    mapping(string => string) public destinationIdentify; // placeID => destination
    mapping(string => string) public destinationAddress; // placeID => destination address
    mapping(string => Review[]) private  destinationReviews; // destinationId => review[]
    mapping(string => uint8[]) private destinationRates; // all rates of a destination

    mapping(bytes32 => Review) public reviewByID;
    mapping(bytes32 => Comment) public commentByID;
    mapping(bytes32 => bool) private reviewVerify;
    mapping(bytes32 => bool) private isReviewFromCheckIn;
    mapping(bytes32 => bool) private isComment;
    mapping(bytes32 => Comment[]) private commentsOfReviewPost;
    // Ticket Check
    // mapping(string => mapping(string => bool)) private isActive; //check for a ticket in place is active yet
    // // mapping (string  => mapping (string => bool)) private isUsed; //check for a ticket in place is used yet
    // mapping(string => mapping(string => bool)) public isVerify; // check for a ticket in place is used for review post
    // // Check for vote one time
    mapping(address => mapping(bytes32 => bool)) public isVoted;
    // Review votes
    mapping(bytes32 => Vote[]) public reviewVotes;
    // Reward
    mapping(bytes32 => bool) private isDivideReward;
    modifier onlyAdmin() {
        require(
            isAdmin[msg.sender] == true,
            "Only admin can call this function"
        );
        _;
    }
    modifier registerCheck() {
        if (isRegister[msg.sender] == false) {
            revert NotRegister({Address: msg.sender});
        }
        _;
    }
    event Register(address TouristAddress);
    function register() public {
        require(
            isRegister[msg.sender] == false,
            "This address has been existed"
        );
        touristREP[msg.sender] = 15;
        touristVP[msg.sender] = 100;
        isRegister[msg.sender] = true;
        emit Register(msg.sender);
    }

    function addDestination(
        string memory _id,
        string memory destinationName,
        string memory destinationAddr
    ) public onlyAdmin {
        destinationIdentify[_id] = destinationName;
        destinationAddress[_id] = destinationAddr;
    }

    event CheckIn(
        bytes32 indexed postID,
        string indexed placeID,
        address TouristAddress
    );
    function checkIn(string memory placeID) public registerCheck {
        if (bytes(destinationIdentify[placeID]).length == 0) {
            revert InvalidPlaceID({PlaceID: placeID});
        }
        bytes32 postID = keccak256(
            abi.encodePacked(msg.sender, block.timestamp)
        );
        isReviewFromCheckIn[postID] = true;
        emit CheckIn(postID, placeID, msg.sender);
    }

    event PostReview(
        address TouristAddress,
        bytes32 indexed postID,
        string indexed PlaceName,
        string review,
        uint8 rate,
        string title
    );

    function reviews(
        string memory placeID,
        bytes32 postID,
        string memory review,
        uint8 rate,
        string memory title
    ) public registerCheck{
        if (bytes(destinationIdentify[placeID]).length == 0) {
            revert InvalidPlaceID({PlaceID: placeID});
        }
        if (
            postID ==
            0x0000000000000000000000000000000000000000000000000000000000000000
        ) {
            postID = keccak256(
                abi.encodePacked(
                    msg.sender,
                    placeID,
                    review,
                    rate,
                    title,
                    block.timestamp
                )
            );
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
        emit PostReview(
            msg.sender,
            newReview.postID,
            placeID,
            review,
            rate,
            title
        );
    }

    function getAllReviewsOfTourist(address addr)
        public
        view
        returns (Review[] memory)
    {
        return TouristReviews[addr];
    }

    function getAllReviewsOfDestinations(string memory _id)
        public
        view
        returns (Review[] memory)
    {
        return destinationReviews[_id];
    }

    // function addPlaceTicket(string memory placeId, string memory ticketId)
    //     public
    //     onlyAdmin
    // {
    //     isActive[placeId][ticketId] = true;
    // }

    function getDestinationRates(string memory placeID)
        public
        view
        returns (uint8[] memory)
    {
        return destinationRates[placeID];
    }

    function addAdmin(address userAddress) external onlyAdmin {
        isAdmin[userAddress] = true;
    }
    event Upvote(address touristAddress, bytes32 postID);
    function upvote(bytes32 postID) public {
        if (
            (bytes32(reviewByID[postID].postID) == 0x0000000000000000000000000000000000000000000000000000000000000000)
            &&
            (!isComment[postID])
        ) {
            revert InvalidPostID({PostID: postID});
        }
        if (isRegister[msg.sender] == false) {
            revert NotRegister({Address: msg.sender});
        }
        if (isVoted[msg.sender][postID] == true) {
          revert PostIsVoted({
            PostID: postID,
             Address: msg.sender
          });
        }
        uint VP = touristVP[msg.sender];
        uint REP = touristREP[msg.sender];
        if (VP < 2 && VP > 100) {
          revert InvalidVP({
            Address: msg.sender,
            VotingPower: VP
          });
        }
        if (!isComment[postID]) {
            Review storage reviewPost = reviewByID[postID];
            reviewPost.upvoteNum++;
            string memory destID = reviewPost.placeId;
            Review[] storage destReviews = destinationReviews[destID];
            for (uint32 i = 0; i < destReviews.length; i++) {
                if (destReviews[i].postID == postID) {
                    destReviews[i].upvoteNum++;
                    break;
                }
            }
        } else {
            Comment storage commentPost = commentByID[postID];
            commentPost.upvoteNum++;
            Comment[] storage reviewComments = commentsOfReviewPost[commentPost.reviewPostID];
            for (uint32 i = 0; i < reviewComments.length; i++) {
                if (reviewComments[i].postID == postID) {
                    reviewComments[i].upvoteNum++;
                    break;
                }
            }
        }
        //Tao vote

        Vote memory newVote;
        newVote.curator = msg.sender;
        newVote.curatorREP = REP;
        newVote.curatorVP = VP;
        // cap nhat cho bai review
        reviewVotes[postID].push(newVote);
        // update VP cho curator
        touristVP[msg.sender] -= 2;
        // update isVoted
        isVoted[msg.sender][postID] = true;
        emit Upvote(msg.sender, postID);
    }

    function getVoteOfReview(bytes32 postID)
        public
        view
        returns (Vote[] memory)
    {
        return reviewVotes[postID];
    }

    function calculateTotalReward(bytes32 postID)
        public 
        view
        returns (uint256)
    {
        // require(block.timestamp - reviewByID[postID].createTime > 7 days, "Wait for 7days");
        require(reviewVerify[postID] == true);
        // lấy mảng vote ra
        Vote[] memory upvotes = getVoteOfReview(postID);
        uint256 voteNum;
        address authorAddress;
        if (!isComment[postID]) {
            voteNum = reviewByID[postID].upvoteNum;
            authorAddress = reviewByID[postID].author;
        } else {
            voteNum = commentByID[postID].upvoteNum;
            authorAddress = commentByID[postID].author;
        }
        uint curatorRep;
        uint totalReward = 0;
        uint totalRep = 0;
        // tinh toan gia tri thuong
        for (uint32 i = 0; i < voteNum; i++) {
            curatorRep = upvotes[i].curatorREP;
            totalReward += curatorRep * 1;
            totalRep += curatorRep;
        }
        if (!isComment[postID]) totalReward += touristREP[authorAddress] * 1;
        return totalReward;
    }

    mapping(address => mapping(bytes32 => uint256))
        public touristRewardOnPostID;
    event DivideRewardBy4R(
        bytes32 indexed postID,
        uint256 indexed authorReward,
        uint256 indexed curatorsReward,
        Vote[] upvotes
    );

    function divideRewardBy4R(bytes32 postID) public registerCheck{
         if (
            bytes32(reviewByID[postID].postID) == 0x0000000000000000000000000000000000000000000000000000000000000000
            &&
            !isComment[postID]
        ) {
            revert InvalidPostID({PostID: postID});
        }

        if (isDivideReward[postID] == true) {
            revert();
        }

        if (reviewVerify[postID] == false) {
            revert("Not Verified");
        }
        uint256 totalReward;
        address authorAddress;
        if (!isComment[postID]) authorAddress = reviewByID[postID].author;
        else authorAddress = commentByID[postID].author;
        
        uint256 totalRep;

        totalReward = calculateTotalReward(postID);
        Vote[] memory upvotes = reviewVotes[postID];
        for (uint32 i = 0; i < upvotes.length; i++) {
            totalRep += upvotes[i].curatorREP;
        }

        totalReward = totalReward * (1 ether);
        uint256 authorReward = (totalReward * 75) / 100;
        if (!isComment[postID])
        {
            touristRewardOnPostID[authorAddress][postID] = authorReward;
            listReward[authorAddress].push(postID);
        }
        uint256 curatorsReward = (totalReward * 25) / 100;

        for (uint32 i = 0; i < upvotes.length; i++) {
            uint256 repIndex = (totalRep / upvotes[i].curatorREP);
            if (repIndex == 0) repIndex = 1;
            address temp = upvotes[i].curator;
            uint256 curatorVP = upvotes[i].curatorVP;
            listReward[temp].push(postID);
            touristRewardOnPostID[temp][postID] =
                ((curatorsReward / repIndex) * curatorVP) /
                100;
        }
        touristREP[authorAddress] += Math.sqrt(totalRep);
        isDivideReward[postID] = true;
        emit DivideRewardBy4R(postID, authorReward, curatorsReward, upvotes);
    }

    function seeRewardLists() public view returns (bytes32[] memory) {
        return listReward[msg.sender];
    }

    function getRewardPoint(bytes32 postID) public {
        require(
            touristRewardOnPostID[msg.sender][postID] > 0,
            "Invalid Reward"
        );
        uint reward = touristRewardOnPostID[msg.sender][postID];
        touristRewardOnPostID[msg.sender][postID] = 0;
        erc20Token.getRewardPoint(
            msg.sender,
            reward
        );
    }

    // function verifyTicket(bytes32 postID, string memory ticketID) public {
    //     Review storage review = reviewByID[postID];
    //     if (
    //         bytes32(reviewByID[postID].postID) ==
    //         0x0000000000000000000000000000000000000000000000000000000000000000
    //     ) {
    //         revert InvalidPostID({PostID: postID});
    //     }
    //     if (isActive[review.placeId][ticketID] == false) {
    //         revert InvalidTicketID({
    //             PlaceID: review.placeId,
    //             TicketID: ticketID
    //         });
    //     }
    //     if (isVerify[review.placeId][ticketID] == true) {
    //         revert TicketIsVerified({
    //             PlaceID: review.placeId,
    //             TicketID: ticketID
    //         });
    //     }
    //     if (reviewVerify[postID] == true) {
    //         revert("This Post Has Verified");
    //     }
    //     isVerify[review.placeId][ticketID] = true;
    //     reviewVerify[postID] = true;
    // }
    event PostComment(address touristAddress,bytes32 postID, string content);
    function comment(bytes32 postID, string memory content) public  {
        if (isRegister[msg.sender] == false) {
            revert NotRegister({Address: msg.sender});
        }
        if (
            bytes32(reviewByID[postID].postID) ==
            0x0000000000000000000000000000000000000000000000000000000000000000
        ) {
            revert InvalidPostID({PostID: postID});
        }
        bytes32 id = keccak256(
            abi.encodePacked(msg.sender, block.timestamp)
        );
        Comment memory newComment;
        newComment.author = msg.sender;
        newComment.postID = id;
        newComment.createTime = block.timestamp;
        newComment.content = content;
        newComment.reviewPostID = postID;
        commentsOfReviewPost[postID].push(newComment);
        isComment[id] = true;
        commentByID[id] = newComment;
        if(reviewVerify[postID] == true) reviewVerify[id] = true;
        emit PostComment(msg.sender, id, content);
    }

    function getAllCommentOfReviewPost(bytes32 postID) view public returns(Comment[] memory) {
        return commentsOfReviewPost[postID];
    }
}

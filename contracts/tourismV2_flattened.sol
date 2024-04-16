
// File: @openzeppelin/contracts/utils/Context.sol


// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)

pragma solidity ^0.8.0;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

// File: @openzeppelin/contracts/access/Ownable.sol


// OpenZeppelin Contracts (last updated v4.7.0) (access/Ownable.sol)

pragma solidity ^0.8.0;


/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    function _checkOwner() internal view virtual {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

// File: @openzeppelin/contracts/token/ERC20/IERC20.sol


// OpenZeppelin Contracts (last updated v4.6.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}

// File: @openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol


// OpenZeppelin Contracts v4.4.1 (token/ERC20/extensions/IERC20Metadata.sol)

pragma solidity ^0.8.0;


/**
 * @dev Interface for the optional metadata functions from the ERC20 standard.
 *
 * _Available since v4.1._
 */
interface IERC20Metadata is IERC20 {
    /**
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() external view returns (uint8);
}

// File: @openzeppelin/contracts/token/ERC20/ERC20.sol


// OpenZeppelin Contracts (last updated v4.7.0) (token/ERC20/ERC20.sol)

pragma solidity ^0.8.0;




/**
 * @dev Implementation of the {IERC20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 * For a generic mechanism see {ERC20PresetMinterPauser}.
 *
 * TIP: For a detailed writeup see our guide
 * https://forum.zeppelin.solutions/t/how-to-implement-erc20-supply-mechanisms/226[How
 * to implement supply mechanisms].
 *
 * We have followed general OpenZeppelin Contracts guidelines: functions revert
 * instead returning `false` on failure. This behavior is nonetheless
 * conventional and does not conflict with the expectations of ERC20
 * applications.
 *
 * Additionally, an {Approval} event is emitted on calls to {transferFrom}.
 * This allows applications to reconstruct the allowance for all accounts just
 * by listening to said events. Other implementations of the EIP may not emit
 * these events, as it isn't required by the specification.
 *
 * Finally, the non-standard {decreaseAllowance} and {increaseAllowance}
 * functions have been added to mitigate the well-known issues around setting
 * allowances. See {IERC20-approve}.
 */
contract ERC20 is Context, IERC20, IERC20Metadata {
    mapping(address => uint256) private _balances;

    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    /**
     * @dev Sets the values for {name} and {symbol}.
     *
     * The default value of {decimals} is 18. To select a different value for
     * {decimals} you should overload it.
     *
     * All two of these values are immutable: they can only be set once during
     * construction.
     */
    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5.05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the value {ERC20} uses, unless this function is
     * overridden;
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view virtual override returns (uint8) {
        return 18;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * NOTE: If `amount` is the maximum `uint256`, the allowance is not updated on
     * `transferFrom`. This is semantically equivalent to an infinite approval.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20}.
     *
     * NOTE: Does not update the allowance if the current allowance
     * is the maximum `uint256`.
     *
     * Requirements:
     *
     * - `from` and `to` cannot be the zero address.
     * - `from` must have a balance of at least `amount`.
     * - the caller must have allowance for ``from``'s tokens of at least
     * `amount`.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public virtual override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, allowance(owner, spender) + addedValue);
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        address owner = _msgSender();
        uint256 currentAllowance = allowance(owner, spender);
        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
        unchecked {
            _approve(owner, spender, currentAllowance - subtractedValue);
        }

        return true;
    }

    /**
     * @dev Moves `amount` of tokens from `from` to `to`.
     *
     * This internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `from` must have a balance of at least `amount`.
     */
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(from, to, amount);

        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balances[from] = fromBalance - amount;
        }
        _balances[to] += amount;

        emit Transfer(from, to, amount);

        _afterTokenTransfer(from, to, amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        unchecked {
            _balances[account] = accountBalance - amount;
        }
        _totalSupply -= amount;

        emit Transfer(account, address(0), amount);

        _afterTokenTransfer(account, address(0), amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
     *
     * This internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * @dev Updates `owner` s allowance for `spender` based on spent `amount`.
     *
     * Does not update the allowance amount in case of infinite allowance.
     * Revert if not enough allowance is available.
     *
     * Might emit an {Approval} event.
     */
    function _spendAllowance(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "ERC20: insufficient allowance");
            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }
    }

    /**
     * @dev Hook that is called before any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * will be transferred to `to`.
     * - when `from` is zero, `amount` tokens will be minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens will be burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}

    /**
     * @dev Hook that is called after any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * has been transferred to `to`.
     * - when `from` is zero, `amount` tokens have been minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens have been burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}
}

// File: contracts/tourismV2.sol


pragma solidity ^0.8.0;
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

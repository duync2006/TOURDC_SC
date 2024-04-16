# Solidity API

## ERC20With4RMechanism

_ContractDescription_

### Contract
ERC20With4RMechanism : contracts/tourismV2.sol

ContractDescription

 --- 
### Functions:
### constructor

```solidity
constructor(uint256 initialSupply) public
```

### getRewardPoint

```solidity
function getRewardPoint(address tourist, uint256 value) public
```

inherits ERC20:
### name

```solidity
function name() public view virtual returns (string)
```

_Returns the name of the token._

### symbol

```solidity
function symbol() public view virtual returns (string)
```

_Returns the symbol of the token, usually a shorter version of the
name._

### decimals

```solidity
function decimals() public view virtual returns (uint8)
```

_Returns the number of decimals used to get its user representation.
For example, if `decimals` equals `2`, a balance of `505` tokens should
be displayed to a user as `5.05` (`505 / 10 ** 2`).

Tokens usually opt for a value of 18, imitating the relationship between
Ether and Wei. This is the value {ERC20} uses, unless this function is
overridden;

NOTE: This information is only used for _display_ purposes: it in
no way affects any of the arithmetic of the contract, including
{IERC20-balanceOf} and {IERC20-transfer}._

### totalSupply

```solidity
function totalSupply() public view virtual returns (uint256)
```

_See {IERC20-totalSupply}._

### balanceOf

```solidity
function balanceOf(address account) public view virtual returns (uint256)
```

_See {IERC20-balanceOf}._

### transfer

```solidity
function transfer(address to, uint256 amount) public virtual returns (bool)
```

_See {IERC20-transfer}.

Requirements:

- `to` cannot be the zero address.
- the caller must have a balance of at least `amount`._

### allowance

```solidity
function allowance(address owner, address spender) public view virtual returns (uint256)
```

_See {IERC20-allowance}._

### approve

```solidity
function approve(address spender, uint256 amount) public virtual returns (bool)
```

_See {IERC20-approve}.

NOTE: If `amount` is the maximum `uint256`, the allowance is not updated on
`transferFrom`. This is semantically equivalent to an infinite approval.

Requirements:

- `spender` cannot be the zero address._

### transferFrom

```solidity
function transferFrom(address from, address to, uint256 amount) public virtual returns (bool)
```

_See {IERC20-transferFrom}.

Emits an {Approval} event indicating the updated allowance. This is not
required by the EIP. See the note at the beginning of {ERC20}.

NOTE: Does not update the allowance if the current allowance
is the maximum `uint256`.

Requirements:

- `from` and `to` cannot be the zero address.
- `from` must have a balance of at least `amount`.
- the caller must have allowance for ``from``'s tokens of at least
`amount`._

### increaseAllowance

```solidity
function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool)
```

_Atomically increases the allowance granted to `spender` by the caller.

This is an alternative to {approve} that can be used as a mitigation for
problems described in {IERC20-approve}.

Emits an {Approval} event indicating the updated allowance.

Requirements:

- `spender` cannot be the zero address._

### decreaseAllowance

```solidity
function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool)
```

_Atomically decreases the allowance granted to `spender` by the caller.

This is an alternative to {approve} that can be used as a mitigation for
problems described in {IERC20-approve}.

Emits an {Approval} event indicating the updated allowance.

Requirements:

- `spender` cannot be the zero address.
- `spender` must have allowance for the caller of at least
`subtractedValue`._

### _transfer

```solidity
function _transfer(address from, address to, uint256 amount) internal virtual
```

_Moves `amount` of tokens from `from` to `to`.

This internal function is equivalent to {transfer}, and can be used to
e.g. implement automatic token fees, slashing mechanisms, etc.

Emits a {Transfer} event.

Requirements:

- `from` cannot be the zero address.
- `to` cannot be the zero address.
- `from` must have a balance of at least `amount`._

### _mint

```solidity
function _mint(address account, uint256 amount) internal virtual
```

_Creates `amount` tokens and assigns them to `account`, increasing
the total supply.

Emits a {Transfer} event with `from` set to the zero address.

Requirements:

- `account` cannot be the zero address._

### _burn

```solidity
function _burn(address account, uint256 amount) internal virtual
```

_Destroys `amount` tokens from `account`, reducing the
total supply.

Emits a {Transfer} event with `to` set to the zero address.

Requirements:

- `account` cannot be the zero address.
- `account` must have at least `amount` tokens._

### _approve

```solidity
function _approve(address owner, address spender, uint256 amount) internal virtual
```

_Sets `amount` as the allowance of `spender` over the `owner` s tokens.

This internal function is equivalent to `approve`, and can be used to
e.g. set automatic allowances for certain subsystems, etc.

Emits an {Approval} event.

Requirements:

- `owner` cannot be the zero address.
- `spender` cannot be the zero address._

### _spendAllowance

```solidity
function _spendAllowance(address owner, address spender, uint256 amount) internal virtual
```

_Updates `owner` s allowance for `spender` based on spent `amount`.

Does not update the allowance amount in case of infinite allowance.
Revert if not enough allowance is available.

Might emit an {Approval} event._

### _beforeTokenTransfer

```solidity
function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual
```

_Hook that is called before any transfer of tokens. This includes
minting and burning.

Calling conditions:

- when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
will be transferred to `to`.
- when `from` is zero, `amount` tokens will be minted for `to`.
- when `to` is zero, `amount` of ``from``'s tokens will be burned.
- `from` and `to` are never both zero.

To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks]._

### _afterTokenTransfer

```solidity
function _afterTokenTransfer(address from, address to, uint256 amount) internal virtual
```

_Hook that is called after any transfer of tokens. This includes
minting and burning.

Calling conditions:

- when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
has been transferred to `to`.
- when `from` is zero, `amount` tokens have been minted for `to`.
- when `to` is zero, `amount` of ``from``'s tokens have been burned.
- `from` and `to` are never both zero.

To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks]._

inherits IERC20Metadata:
inherits IERC20:

 --- 
### Events:
inherits ERC20:
inherits IERC20Metadata:
inherits IERC20:
### Transfer

```solidity
event Transfer(address from, address to, uint256 value)
```

_Emitted when `value` tokens are moved from one account (`from`) to
another (`to`).

Note that `value` may be zero._

### Approval

```solidity
event Approval(address owner, address spender, uint256 value)
```

_Emitted when the allowance of a `spender` for an `owner` is set by
a call to {approve}. `value` is the new allowance._

## IERC20With4RMechanism

### Contract
IERC20With4RMechanism : contracts/tourismV2.sol

 --- 
### Functions:
### totalSupply

```solidity
function totalSupply() external view returns (uint256)
```

### balanceOf

```solidity
function balanceOf(address account) external view returns (uint256)
```

### transfer

```solidity
function transfer(address recipient, uint256 amount) external returns (bool)
```

### allowance

```solidity
function allowance(address owner, address spender) external view returns (uint256)
```

### approve

```solidity
function approve(address spender, uint256 amount) external returns (bool)
```

### transferFrom

```solidity
function transferFrom(address sender, address recipient, uint256 amount) external returns (bool)
```

### getRewardPoint

```solidity
function getRewardPoint(address tourist, uint256 value) external
```

 --- 
### Events:
### Transfer

```solidity
event Transfer(address from, address to, uint256 value)
```

### Approval

```solidity
event Approval(address owner, address spender, uint256 value)
```

## Math

### Contract
Math : contracts/tourismV2.sol

 --- 
### Functions:
### sqrt

```solidity
function sqrt(uint256 x) external pure returns (uint128)
```

## NotRegister

```solidity
error NotRegister(address Address)
```

## InvalidPlaceID

```solidity
error InvalidPlaceID(string PlaceID)
```

## InvalidTicketID

```solidity
error InvalidTicketID(string PlaceID, string TicketID)
```

## InvalidPostID

```solidity
error InvalidPostID(bytes32 PostID)
```

## TicketIsVerified

```solidity
error TicketIsVerified(string PlaceID, string TicketID)
```

## TicketNotVerified

```solidity
error TicketNotVerified(string PlaceID, string TicketID)
```

## PostIsVoted

```solidity
error PostIsVoted(bytes32 PostID, address Address)
```

## InvalidVP

```solidity
error InvalidVP(address Address, uint256 VotingPower)
```

## Tourism

### Contract
Tourism : contracts/tourismV2.sol

 --- 
### Modifiers:
### onlyAdmin

```solidity
modifier onlyAdmin()
```

### registerCheck

```solidity
modifier registerCheck()
```

 --- 
### Functions:
### constructor

```solidity
constructor(address ERC20_address) public
```

### register

```solidity
function register() public
```

### addDestination

```solidity
function addDestination(string _id, string destinationName, string destinationAddr) public
```

### checkIn

```solidity
function checkIn(string placeID) public
```

### reviews

```solidity
function reviews(string placeID, bytes32 postID, string review, uint8 rate, string title) public
```

### getAllReviewsOfTourist

```solidity
function getAllReviewsOfTourist(address addr) public view returns (struct Tourism.Review[])
```

### getAllReviewsOfDestinations

```solidity
function getAllReviewsOfDestinations(string _id) public view returns (struct Tourism.Review[])
```

### getDestinationRates

```solidity
function getDestinationRates(string placeID) public view returns (uint8[])
```

### addAdmin

```solidity
function addAdmin(address userAddress) external
```

### upvote

```solidity
function upvote(bytes32 postID) public
```

### getVoteOfReview

```solidity
function getVoteOfReview(bytes32 postID) public view returns (struct Tourism.Vote[])
```

### calculateTotalReward

```solidity
function calculateTotalReward(bytes32 postID) public view returns (uint256)
```

### divideRewardBy4R

```solidity
function divideRewardBy4R(bytes32 postID) public
```

### seeRewardLists

```solidity
function seeRewardLists() public view returns (bytes32[])
```

### getRewardPoint

```solidity
function getRewardPoint(bytes32 postID) public
```

### comment

```solidity
function comment(bytes32 postID, string content) public
```

### getAllCommentOfReviewPost

```solidity
function getAllCommentOfReviewPost(bytes32 postID) public view returns (struct Tourism.Comment[])
```

 --- 
### Events:
### Register

```solidity
event Register(address TouristAddress)
```

### CheckIn

```solidity
event CheckIn(bytes32 postID, string placeID, address TouristAddress)
```

### PostReview

```solidity
event PostReview(address TouristAddress, bytes32 postID, string PlaceName, string review, uint8 rate, string title)
```

### Upvote

```solidity
event Upvote(address touristAddress, bytes32 postID)
```

### DivideRewardBy4R

```solidity
event DivideRewardBy4R(bytes32 postID, uint256 authorReward, uint256 curatorsReward, struct Tourism.Vote[] upvotes)
```

### PostComment

```solidity
event PostComment(address touristAddress, bytes32 postID, string content)
```


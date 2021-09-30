pragma solidity ^0.8.0;

contract InnoCoin {

    string public constant name = "InnoCoin";
    string public constant symbol = "INC";
    uint8 public constant decimals = 18; 
    uint256 public constant priceBuy = 100000;
    uint256 public constant priceSell = 111111111; 
    
    
    address owner;
 

    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
    event Transfer(address indexed from, address indexed to, uint tokens);


    mapping(address => uint256) balances;

    mapping(address => mapping (address => uint256)) allowed;
    
    uint256 totalSupply_;

    using SafeMath for uint256;

   constructor() public payable {  
	totalSupply_ = 10000000000000000000000000;
	balances[address(this)] = totalSupply_;
	owner = msg.sender;
    }  

    function totalSupply() public view returns (uint256) {
	return totalSupply_;
    }
    
    function balanceOf(address tokenOwner) public view returns (uint) {
        return balances[tokenOwner];
    }

    function transfer(address receiver, uint numTokens) public returns (bool) {
        require(numTokens <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender].sub(numTokens);
        balances[receiver] = balances[receiver].add(numTokens);
        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }
    modifier _ownerOnly(){
      require(msg.sender == owner);
      _;
    }
    
    function transferContractBalance(address receiver, uint256 amount) _ownerOnly external{
        require(amount <= address(this).balance);
        (bool success, ) = receiver.call{value: amount}("");
    }
    
    function contractBalance() _ownerOnly external view returns (uint){
        return address(this).balance;
    }
    
    function buy() external payable {
        uint256 amount = msg.value*priceBuy;
        require(amount <= balances[address(this)]);
        balances[address(this)] = balances[address(this)].sub(amount);
        balances[msg.sender] = balances[msg.sender].add(amount);
        emit Transfer(address(this), msg.sender, amount);
    }
    
    function sell(uint256 numTokens) external {
        require(numTokens <= balances[msg.sender], "Not enough InnoCoins");
        require(numTokens <= address(this).balance*priceSell, "Contract balance is low");
        balances[msg.sender] -= numTokens;
        balances[address(this)] += numTokens;
        emit Transfer(msg.sender, address(this), numTokens);
        (bool success, ) = msg.sender.call{value: numTokens/priceSell}("");
    }

    function approve(address delegate, uint numTokens) public returns (bool) {
        allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }

    function allowance(address owner, address delegate) public view returns (uint) {
        return allowed[owner][delegate];
    }

    function transferFrom(address owner, address buyer, uint numTokens) public returns (bool) {
        require(numTokens <= balances[owner]);    
        require(numTokens <= allowed[owner][msg.sender]);
    
        balances[owner] = balances[owner].sub(numTokens);
        allowed[owner][msg.sender] = allowed[owner][msg.sender].sub(numTokens);
        balances[buyer] = balances[buyer].add(numTokens);
        emit Transfer(owner, buyer, numTokens);
        return true;
    }
}

library SafeMath { 
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
      assert(b <= a);
      return a - b;
    }
    
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
      uint256 c = a + b;
      assert(c >= a);
      return c;
    }
}

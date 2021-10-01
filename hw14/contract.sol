pragma solidity ^0.4.19;

contract Storage {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply_;
    
    function setName(string memory _name) public returns (bool success){
        name = _name;
        return true;
    }
    
    function setSymbol(string memory _symbol) public returns (bool success){
        symbol = _symbol;
        return true;
    }
    
    function setDecimals(uint8 _decimals) public returns (bool success){
        decimals = _decimals;
        return true;
    }

    function setTotalSupply(uint256 _totalSupply) public returns (bool success){
        totalSupply_ = _totalSupply;
        return true;
    }
    
    constructor(uint256 total) public {
	    totalSupply_ = total;
    } 
}

contract InnoCoin {

    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
    event Transfer(address indexed from, address indexed to, uint tokens);
    
    Storage storage_;

    mapping(address => uint256) balances;

    mapping(address => mapping (address => uint256)) allowed;
    

    using SafeMath for uint256;


    constructor(uint256 total) public { 
        storage_ = new Storage(total);
        balances[msg.sender] = total;
    }
    
    function setTotalSupply(uint256 val) public returns (bool){
        Storage tmp = Storage(storage_);
        tmp.setTotalSupply(val);
        return true;
    }
     
    function getTotalSupply() public view returns (uint256){
        Storage tmp = Storage(storage_);
        return tmp.totalSupply_();
    }
    
    function setName(string memory name) public returns (bool){
        Storage tmp = Storage(storage_);
        tmp.setName(name);
        return true;
    }
     
    function getName() public view returns (string memory){
        Storage tmp = Storage(storage_);
        return tmp.name();
    }
    
    function setDecimals(uint8 val) public returns (bool){
        Storage tmp = Storage(storage_);
        tmp.setDecimals(val);
        return true;
    }
     
    function getDecimals() public view returns (uint8){
        Storage tmp = Storage(storage_);
        return tmp.decimals();
    }
    
    function setSymbol(string memory val) public returns (bool){
        Storage tmp = Storage(storage_);
        tmp.setSymbol(val);
        return true;
    }
     
    function getSymbol() public view returns  (string memory){
        Storage tmp = Storage(storage_);
        return tmp.symbol();
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

    function approve(address delegate, uint numTokens) public returns (bool) {
        allowed[msg.sender][delegate] = numTokens;
        Approval(msg.sender, delegate, numTokens);
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
        Transfer(owner, buyer, numTokens);
        return true;
    }
}

contract contractsHolder  {
    InnoCoin public dataContract;
    
    // string public constant name = "InnoCoin";
    // string public constant symbol = "INC";
    // uint8 public constant decimals = 18;  
 

    // event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
    // event Transfer(address indexed from, address indexed to, uint tokens);


    // mapping(address => uint256) balances;

    // mapping(address => mapping (address => uint256)) allowed;
    
    // uint256 totalSupply_;

    
    constructor (uint total) public{
        InnoCoin c = new InnoCoin(total);
        dataContract=c;
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
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyToken {
    
    string public name = "MyToken";
    string public symbol = "MTK";
    uint8 public decimals = 18;

    uint256 public totalSupply;
    uint256 public constant MAX_SUPPLY = 1_000_000 * (10 ** 18);

    address public owner;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    // --- События ---
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // --- Модификатор ---
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    // --- Конструктор ---
    constructor() {
        owner = msg.sender;
    }

    // --- Передача токенов ---
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    // --- Разрешение на перевод ---
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    // --- Перевод от имени другого пользователя ---
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[_from] >= _value, "Insufficient balance");
        require(allowance[_from][msg.sender] >= _value, "Allowance exceeded");
        balanceOf[_from] -= _value;
        allowance[_from][msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    // --- Эмиссия токенов (mint) ---
    function mint(address _to, uint256 _amount) public onlyOwner {
        require(totalSupply + _amount <= MAX_SUPPLY, "Max supply exceeded");
        totalSupply += _amount;
        balanceOf[_to] += _amount;
        emit Transfer(address(0), _to, _amount);
    }
}

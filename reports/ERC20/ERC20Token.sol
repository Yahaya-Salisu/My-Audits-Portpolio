// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "./IERC20Token.sol";

contract ERC20Token {
    string name;
    string symbol;
    uint256 decimals;
    uint256 totalSupply;
    uint256 maxMint = 1_00_000e18;
    uint256 minMint = 10e18;

    event Transfer(address indexed _from, address indexed _to, uint256 _amount);
    event Mint(address indexed _to, uint256 amount);
    event TransferFrom(address indexed _from, address indexed _to, uint256 _amount);
    event Burn(address indexed _from, address indexed _to, uint256 _amount);

    mapping(address => uint256) public balances;

    mapping(address => mapping(address => uint256)) public allowances;

    constructor(string memory _name, string memory _symbol, uint256 _decimals, uint256 _totalSupply) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _totalSupply;
    }

    function balanceOf(address _user) external view returns(uint256 balance) {
        return balances[_user];
    }

    function transfer(address _from, address _to, uint256 _amount) external returns(bool success) {
        require(balances[msg.sender] >= _amount && _amount > 0, "No sufficeint balance");
        if(_from != address(0) && _to != address(0)) {
            balances[_from] -= _amount;
            balances[_to] += _amount;
            emit Transfer(_from, _to, _amount);
        }
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _amount) external payable returns(bool succes) {
        require(allowances[_from][_to] >= _amount && _amount > 0, "transferFrom failed");
        allowances[_from][_to] -= _amount;
        balances[_from] -= _amount;
        balances[_to] += _amount;
        emit TransferFrom(_from, _to, _amount);
        return true;
    }

    function approve(address _spender, uint256 _value) external returns(bool success) {
        require(balances[msg.sender] >= _value && _spender != address(0));
        allowances[msg.sender][_spender] = _value;
        return true;
    }

    function allowance(address _owner, address _spender) external view returns(uint256 remaining) {
        return allowances[_owner][_spender];
    }

    function mint(address _to, uint256 amount) external returns(uint256) {
        require(_to != address(0), "Can not mint to address(0)");
        if (amount > minMint && amount <= maxMint) {
           balances[msg.sender] += amount;
           emit Mint(_to, amount);
        }
        return amount;


    }

    function burn(address _from, uint256 _amount) external {
          require(balances[msg.sender] >= _amount && _amount > 0, "Can not burn from address(0)");
          balances[_from] -= _amount;
          emit Burn(_from, address(0), _amount);
    }
}

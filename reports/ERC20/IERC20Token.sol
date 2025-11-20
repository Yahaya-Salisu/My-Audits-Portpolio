// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

interface IERC20 {

    function name() external view returns(string memory);

    function symbol() external view returns(string memory);

    function decimals() external view returns(uint256);

    function totalSupply() external view returns(uint256);

    function balanceOf(address _owner) external view returns(uint256 balance);

    function transfer(address _to, uint256 _amount) external returns(bool success);

    function transferFrom(address _from, address _to, uint256 _amount) external returns(bool succes);

    function approve(address _spender, uint256 _value) external view returns(bool success);

    function allowance(address _owner, address _spender) external view returns(uint256 remaining);

    function mint(address _to, uint256 amount) external returns(uint256);

    function burn(address _from, address _to, uint256 _amount) external;
}

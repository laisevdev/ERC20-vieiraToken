//SPDX-License-Identifier:MIT
pragma solidity ^0.8.13;


contract VIEIRATOKEN {

string public name = "VIEIRA";
string public simbol = "VRA";
address public owner;
uint256 public supplyTotal;
uint256 decimals = 8; 
mapping (address => uint256) balances;
mapping (address => mapping (address => uint256)) allowance;

modifier OnlyOwner () {
        require(msg.sender == owner);
        _;
}

event Transfer(address indexed _from, address indexed to, uint256 _value);
event Approval(address indexed _owner, address indexed _spender, uint256 _amount);

constructor() {
       owner = msg.sender;
       supplyTotal = 30000 * 10 ** decimals;
       balances[msg.sender] = supplyTotal; 
}


        function changeName(string memory _name) public OnlyOwner {
                name = _name;
        }


        function changeSimbol(string memory newSimbol) public OnlyOwner {
                simbol = newSimbol;
        }

        function _supplyTotal() public view returns (uint256) {
                return  supplyTotal;
        }

        function balanceOf(address owner_) public view returns (uint256) {
                return balances[owner_];
        }

        function transfer(address to, uint256 value) public returns (bool) {
                require(balances[msg.sender] >= value, "Insufficient funds");
                balances[msg.sender] = balances[msg.sender] - value;
                balances[to] = balances[to] + value;

                emit Transfer(msg.sender, to, value);

                return true;
        }

          function allowances(address _owner, address _spender) public view returns (uint256) {
                return allowance[_owner][_spender];
        }

        function approve(address spender, uint256 amount) public returns (bool) {
                allowance[msg.sender][spender] = amount;

                emit Approval(msg.sender, spender, amount);
                
                return true;
        }

        function transferFrom(address from, address to, uint256 amount) public returns (bool) {
                require(balances[from] >= amount, "You don't have enough balance");

                require(allowances(from, msg.sender) >= amount, "There is not permission");

                balances[from] = balances[from] - amount;
                balances[to] = balances[to] + amount;

                allowance[from][msg.sender] = allowance[from][msg.sender] - amount;

                emit Transfer(from, to, amount);

                return true;
        }

        function burnTokens(uint256 amount) public OnlyOwner returns (bool) {
                require(msg.sender != address(0), "You are trying burn tokens from the zero address");

                _beforeTokenTransfer(msg.sender, address(0), amount);

                uint256 accountBalance = balances[msg.sender];
                require(accountBalance >= amount, "Burn tokens amount exceeds the balance");
                balances[msg.sender] = accountBalance - amount;
                supplyTotal -= amount;

                 emit Transfer(msg.sender, address(0), amount);

                 _afterTokenTransfer(msg.sender, address(0), amount);

                return true;
        }

         function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual {}

          function _afterTokenTransfer(address from, address to, uint256 amount) internal virtual {}

        // SUH- 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
        // LAH- 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
        // GIO - 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db

}
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Wallet {

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

    modifier checkOwnerAndAccept {
        require(msg.pubkey() == tvm.pubkey(), 100);
		tvm.accept();
		_;
	}
    

    function sendTransactionPayingComissionWithBounce(address dest, uint128 value) public pure checkOwnerAndAccept {
        dest.transfer(value, true, 1);
    }

    function sendTransactionNotPayingComissionWithBounce(address dest, uint128 value) public pure checkOwnerAndAccept {
        dest.transfer(value, true, 0);
    }
    
    function sendAllAndDestroyWalletWithBounce(address dest) public pure checkOwnerAndAccept {
        dest.transfer(1, true, 160);
    }

    function sendTransactionPayingComissionNoBounce(address dest, uint128 value) public pure checkOwnerAndAccept {
        dest.transfer(value, false, 1);
    }

    function sendTransactionNotPayingComissionNoBounce(address dest, uint128 value) public pure checkOwnerAndAccept {
        dest.transfer(value, false, 0);
    }
    
    function sendAllAndDestroyWalletNoBounce(address dest) public pure checkOwnerAndAccept {
        dest.transfer(1, false, 160);
    }

}
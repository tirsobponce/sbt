// Copyright (c) Blockus
// Author: Tirso J. Bello Ponce (tirso@blockus.gg)


#[test_only]
module sbt::sbt_tests {

    #[test]
    fun mint_sbt_exchange_for_nft() {
        let mut test = sbt::test_utils::new();
        let ctx = &mut test.next_tx(@0x1);

        // Mint 2 Soul Bound Tokens (SBT)
        let sbt_one = sbt::sbt::mint(ctx);
        let sbt_two = sbt::sbt::mint(ctx);

        // Pack the SBT into a vector.
        let mut sbts = vector::empty();

        sbts.push_back(sbt_one);
        sbts.push_back(sbt_two);

        // Exchange the SBTs for a minting voucher
        let voucher = sbt::sbt::mint_voucher(sbts);

        // Exchange the minting voucher for a NFT.
        let exclusive_nft = sbt::sbt::mint_exclusively(voucher, ctx);

        test.destroy(exclusive_nft);
    }

    #[test]
     #[expected_failure(abort_code = sbt::sbt::EInsufficientAmount)]
    fun mint_sbt_exchange_for_nft_fail() {
        let mut test = sbt::test_utils::new();
        let ctx = &mut test.next_tx(@0x1);

        // Mint 1 Soul Bound Tokens (SBT)
        let sbt_one = sbt::sbt::mint(ctx);

        // Pack the SBT into a vector.
        let mut sbts = vector::empty();

        sbts.push_back(sbt_one);

        // Exchange the SBTs for a minting voucher
        let voucher = sbt::sbt::mint_voucher(sbts);

        // Exchange the minting voucher for a NFT.
        let exclusive_nft = sbt::sbt::mint_exclusively(voucher, ctx);

        test.destroy(exclusive_nft);
    }
}

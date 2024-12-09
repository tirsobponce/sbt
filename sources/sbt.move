// Copyright (c) Blockus
// Author: Tirso J. Bello Ponce (tirso@blockus.gg)


module sbt::sbt {
    public struct SoulBoundToken has key {
        id: UID,
    }

    public struct ExclusiveNFT has key, store {
        id: UID,
    }

    public struct ExclusiveNFTVoucher  {
        amount: u64,
    }

    #[error]
    const EInsufficientAmount: vector<u8> = 
        b"Insufficient amount of SBTs to trade.";

    const MIN_AMOUNT: u64 = 2;

    // Mint a Soul Bound Token (SBT)
    public fun mint(ctx: &mut TxContext): SoulBoundToken {
        let sbt = SoulBoundToken {
            id: object::new(ctx),
        };
        
        (sbt)
    }

    public fun mint_voucher(mut sbts: vector<SoulBoundToken>): ExclusiveNFTVoucher {
        let mut elements = sbts.length();
        let total_nfts = sbts.length();

        while (elements > 0) {
            let sbt = sbts.pop_back();
            consume(sbt);
            elements = elements - 1;
        };

        vector::destroy_empty(sbts);

        let voucher = ExclusiveNFTVoucher {
            amount: total_nfts,
        };

        (voucher)
    }

    public fun mint_exclusively(voucher: ExclusiveNFTVoucher, ctx: &mut TxContext): ExclusiveNFT {

        let ExclusiveNFTVoucher { amount} = voucher;

        assert!(amount >= MIN_AMOUNT, EInsufficientAmount);

        let exclusive = ExclusiveNFT {
            id: object::new(ctx),
        };

        (exclusive)
    }


    fun consume(sbt: SoulBoundToken) {
        let SoulBoundToken {
            id,
        } = sbt;
        object::delete(id);
    }
}

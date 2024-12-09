// Copyright (c) Blockus
// Author: Tirso J. Bello Ponce (tirso@blockus.gg)

#[test_only]
module sbt::test_utils {
    public struct TestRunner has drop { seq: u64 }

    public fun new(): TestRunner {
        TestRunner { seq: 1 }
    }

    public fun next_tx(self: &mut TestRunner, sender: address): TxContext {
        self.seq = self.seq + 1;
        tx_context::new_from_hint(
            sender,
            self.seq,
            0,
            0,
            0
        )
    }

    public fun destroy<T>(self: &TestRunner, t: T): &TestRunner {
        sui::test_utils::destroy(t);
        self
    }
}
class TransactionRecordPoolState {
    let coin: Coin

    var records = [TransactionRecord]()
    var firstUnusedIndex = 0
    var allLoaded = false

    init(coin: Coin) {
        self.coin = coin
    }

    var unusedRecords: [TransactionRecord] {
        return Array(records.suffix(from: firstUnusedIndex))
    }

    func add(records: [TransactionRecord]) {
        self.records.append(contentsOf: records)
    }

    func index(ofRecord record: TransactionRecord) -> Int? {
        return records.firstIndex(of: record)
    }

    func insertIndex(ofRecord record: TransactionRecord) -> Int? {
        return records.firstIndex(where: { $0.timestamp < record.timestamp })
    }

    func set(record: TransactionRecord, atIndex index: Int) {
        records[index] = record
    }

    func insert(record: TransactionRecord, atIndex index: Int) {
        records.insert(record, at: index)
    }

}

import Foundation
import RealmSwift
import RxSwift

class TransactionSender {
    let disposeBag = DisposeBag()

    let realmFactory: RealmFactory
    let peerGroup: PeerGroup

    private var notificationToken: NotificationToken?

    init(realmFactory: RealmFactory, peerGroup: PeerGroup, scheduler: ImmediateSchedulerType = ConcurrentDispatchQueueScheduler(qos: .background), queue: DispatchQueue = .global(qos: .background)) {
        self.realmFactory = realmFactory
        self.peerGroup = peerGroup

//        peerGroup.statusSubject
//                .observeOn(scheduler)
//                .subscribe(onNext: { [weak self] status in
//                    if status == .connected {
//                        self?.resend()
//                    }
//                }).disposed(by: disposeBag)
//
//        notificationToken = realmFactory.realm.objects(Transaction.self).filter("status = %@", TransactionStatus.new.rawValue).observe { changes in
//            DispatchQueue.main.async { [weak self] in
//                if case let .update(transactions, _, insertions, _) = changes, !insertions.isEmpty {
//                    self?.send(transactions: transactions)
//                }
//            }
//        }
    }

    private func resend() {
        let realm = realmFactory.realm

        let nonSentTransactions = realm.objects(Transaction.self).filter("status = %@", TransactionStatus.new.rawValue)
        send(transactions: nonSentTransactions)
    }

    private func send(transactions: Results<Transaction>) {
        transactions.forEach {
            peerGroup.relay(transaction: $0)
        }
    }

    deinit {
        notificationToken?.invalidate()
    }

}
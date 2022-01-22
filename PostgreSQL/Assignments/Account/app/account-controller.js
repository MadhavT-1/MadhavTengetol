const db = require('../db/models');
const account = db.Account;

exports.findAll = (req, res) => {
    account.findAll()
        .then(accounts => {
            res.json(accounts);
        })
        .catch(err => {
            res.status(500).send({
                message: err.message || "Some error occurred while retrieving accounts."
            });
        });
};

exports.findOne = (req, res) => {
    const id = parseInt(req.params.id);
    account.findByPk(id)

        .then(account => {
            if (!account) {
                return res.status(404).send({
                    message: "Account not found with id " + id
                });
            }
            res.send(account);
        })
        .catch(err => {
            if (err.kind === 'ObjectId') {
                return res.status(404).send({
                    message: "Account not found with id " + id
                });
            }
            return res.status(500).send({
                message: "Error retrieving account with id " + id
            });
        });
};

exports.create = (req, res) => {
    // Validate request
    // if (!req.body.accountNo) {
    //     return res.status(400).send({
    //         message: "accountNo can not be empty"
    //     });
    // }

    // Create a Account
    const accountData = {
        accountNo: req.body.accountNo,
        accName: req.body.accName,
        balance: req.body.balance
    };

    account.create(accountData)
        .then(data => {
            res.json(data);
        })
        .catch(err => {
            res.status(500).send({
                message: err.message || "Some error occurred while creating the Account."
            });
        });
};

exports.update = (req, res) => {
    const id = parseInt(req.params.id);
    account.update({
        accountNo: req.body.accountNo,
        accName: req.body.accName,
        balance: req.body.balance
    }, { where: { id: id } })
        .then(num => {
            res.send({
                message: `Account was updated successfully.`
            });
        })
        .catch(err => {
            res.status(500).send({
                message: "Error updating account with id=" + id
            });
        });
};

exports.destroy = (req, res) => {
    const id = parseInt(req.params.id);

    account.destroy({
        where: { id: id }
    })
        .then(num => {
            res.send({
                message: `Account was deleted successfully!`
            });
        })
        .catch(err => {
            res.status(500).send({
                message: "Could not delete account with id=" + id
            });
        });
};

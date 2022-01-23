'use strict';

module.exports = {
  async up(queryInterface, Sequelize) {

    await queryInterface.bulkInsert('Accounts', [
      {
        accountNo: '123456789',
        accName: 'Account 1',
        balance: '100',
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        accountNo: '987654321',
        accName: 'Account 2',
        balance: '200',
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        accountNo: '123456789',
        accName: 'Account 3',
        balance: '300',
        createdAt: new Date(),
        updatedAt: new Date()
      }

    ], {});

  },

  async down(queryInterface, Sequelize) {
    /**
     * Add commands to revert seed here.
     *
     * Example:
     * await queryInterface.bulkDelete('People', null, {});
     */
  }
};

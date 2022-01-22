'use strict';

module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.bulkInsert('Authors', [
      {
        authorName: 'J.K. Rowling',
        bookName: 'Harry Potter and the Philosopher\'s Stone',
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        authorName: 'J.K. Rowling',
        bookName: 'Harry Potter and the Chamber of Secrets',
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        authorName: 'J.K. Rowling',
        bookName: 'Harry Potter and the Prisoner of Azkaban',
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

'use strict';

module.exports = {
  async up(queryInterface, Sequelize) {


    await queryInterface.bulkInsert('Heros', [
      {
        heroName: 'Tony Stark',
        film: 'Iron Man',
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        heroName: 'Thor',
        film: 'Thor',
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        heroName: 'Steve Rogers',
        film: 'Captain America',
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

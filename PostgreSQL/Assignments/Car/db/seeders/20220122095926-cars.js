'use strict';

module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.bulkInsert('Cars', [
      {
        carName: 'X5',
        brand: 'BMW',
        createdAt: new Date(),
        updatedAt: new Date()
      
      },
      {
        carName: 'X6',
        brand: 'BMW',
        createdAt: new Date(),
        updatedAt: new Date()
      }
    ], {});
    
  },

  async down (queryInterface, Sequelize) {
    /**
     * Add commands to revert seed here.
     *
     * Example:
     * await queryInterface.bulkDelete('People', null, {});
     */
  }
};

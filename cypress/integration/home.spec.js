describe('home page', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000')
  })
  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });
  it("There is 11 products on the page", () => {
    cy.get(".products article").should("have.length", 11);
  });
})


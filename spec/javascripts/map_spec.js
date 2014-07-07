// $(".highcharts-tooltip").attr('visibility')


// describe("Map", function() {
//   var oven;

//   beforeEach(function() {
//     oven = new Oven();
//     cookie1 = new Cookie('chocolate chip', 14)
//     cookie2 = new Cookie('chocolate chip', 14)
//     cookie3 = new Cookie('chocolate chip', 14)
//   });

//   it("should have a default size of 3 with no params", function() {
//     expect(oven.maxSize).toEqual(3);
//   })

//   it('should have empty contents on initialize', function() {
//     expect(oven.contents).toEqual([]);
//   })

//   describe('addItem', function() {
//     it('should increase size of oven contents', function() {
//       oven.addItem('cookie');
//       expect(oven.contents.length).toEqual(1);
//     })

//     it("should not add item if max size is reached", function() {
//       spyOn(window, 'alert');
//       for(i = 0; i <= oven.maxSize; i++) { oven.addItem('cookie'); }
//         expect(window.alert).toHaveBeenCalledWith("TOO MANY");
//     })
//   })

//   describe('removeItem', function() {
//     it('should increase size of oven contents', function() {
//       oven.addItem('cookie');
//       oven.removeItem('cookie');
//       expect(oven.contents.length).toEqual(0);
//     })
//   })

//   describe('bake', function() {
//     it("should bake contents for 1 minute", function() {
//       oven.addItem(cookie1);
//       oven.addItem(cookie2);
//       oven.addItem(cookie3);
//       oven.bake();
//       expect(oven.contents[0].bakeTime).toEqual(1);
//     })
//   })
// })

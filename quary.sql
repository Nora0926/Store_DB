use storeSys;

--- (1) 점포번호 "100005"에서 일하는 직원들의 이름(일반)
SELECT e.emp_name
FROM storework s, employee e
WHERE s.empID = e.empID AND s.storeID = '100005';

--- (2) 물류센터에서 급여가 가장 높은 직원이 일하는 곳의 번호와 이름
SELECT cw.centID, dc.center_name
FROM employee e, centerWork cw, distriCenter dc
WHERE cw.empID = e.empID AND cw.centID = dc.centerID AND e.salary = (SELECT MAX(salary)
																	                                   FROM employee
																	                                   WHERE empID IN (SELECT empID
                                                                                     FROM centerWork));

--- (3) "400009" 상품이 공급되는 점포이름(일반)
SELECT s.store_name, d.center_name
FROM store s, districenter d, supply sp, product p
WHERE s.storeID = sp.storeID AND 
      sp.productID = p.productID AND 
	    d.centerID = sp.centID AND 
      p.productID = '400009';
      
--- (4) 각 점포별 직원들의 급여 평균
SELECT s.storeID, s.store_name, AVG(e.salary)
FROM store s, storeWork sw, employee e
WHERE s.storeID = sw.storeID AND 
      sw.empID = e.empID
GROUP BY s.storeID, s.store_name;

--- (5) "150000"보다 평균 연봉이 높은 모든 물류센터의 평균 연봉과 이름
SELECT d.center_name, AVG(e.salary)
FROM distriCenter d, centerWork cw, employee e
WHERE d.centerID = cw.centID AND 
      cw.empID = e.empID
GROUP BY d.centerID, d.center_name
HAVING AVG(e.salary) > 150000;

--- (6) 유수호 배달기사가 배달한 상품들을 전달받은 손님의 이름
SELECT c.consum_name
FROM consumer c, reservation r, delivMan d
WHERE c.consumID = r.consumID AND 
      r.delivID = d.delivID AND 
      d.deliv_name = '유수호';

--- (7)  "기타" 사유로 반품된 상품들의 개수
SELECT COUNT(*)
FROM takeBack
WHERE reason = '기타';

---(8) 경상북도에 위치한 점포에 모두 납품되는 상품명
SELECT p.product_name
FROM product p
WHERE EXISTS (SELECT *
			  FROM store s
			  WHERE s.address LIKE '%경상북도%' AND NOT EXISTS (SELECT *
															                           FROM supply sp
															                           WHERE sp.productID = p.productID AND 
                                                               sp.storeID = s.storeID));

--- (9) 토레타 제로와 세트로 팔리는 상품
SELECT p.product_name
FROM product p
WHERE p.setProductID = '400005';

--- (10) 주예수가 근무하는 점포 이름
SELECT s.store_name
FROM store s, storeWork sw, employee e
WHERE s.storeID = sw.storeID AND 
      sw.empID = e.empID AND 
      e.emp_name = '주예수';

WITH t AS(
      SELECT 
          CAST(REGEXP_REPLACE(userid,'[^0-9 ]','') AS INT64) AS userid,
          CASE
          WHEN transactiontype = 'Vendor2User' OR transactiontype = 'Deposit'
          THEN 'Deposit'
          ELSE 'Withdraw'
          END AS transactiontype,
          transactioncompleted,
          (creditamount*eurcreditexchangerate) as amounteur,
          creditamount as amount,
          eurcreditexchangerate as eurexchangerate,
          creditcurrency as currency,
          transid,
          lastnote       
      FROM mysql.Transaction
      WHERE (transactionstatus = 'Success' OR transactionstatus = 'RollBack')
              AND (  transactiontype='Deposit' OR transactiontype='Withdraw' OR transactiontype='Vendor2User' OR transactiontype='User2Agent'  )
              AND creditamount<>0),

      p AS (
           SELECT 
               `stitch-test-296708.mysql.Posting`.userid AS userid,
               'Deposit' AS transactiontype,
                postingcompleted as transactioncompleted,
                amount*eurexchangerate AS amounteur,
                amount,
                eurexchangerate,
                currency,
                `stitch-test-296708.mysql.Posting` .transid,
                'AMS Deposit' AS lastnote
            FROM `stitch-test-296708.mysql.Posting` 

            FULL JOIN mysql.Transaction ON  `stitch-test-296708.mysql.Posting`.transid=Transaction.transid
            WHERE `stitch-test-296708.mysql.Posting`.amount > 0
                  AND `stitch-test-296708.mysql.Posting`.wallet='RealCash'
                  AND Transaction.transactiontype='Agent2User')


SELECT *
FROM t
UNION ALL
SELECT *
FROM p
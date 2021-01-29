SELECT CAST(REGEXP_REPLACE(userid,'[^0-9 ]','') AS INT64) AS userid,
       CASE
       WHEN transactiontype='Vendor2User' 
        OR transactiontype='Deposit'
        OR transactiontype='User2Vendor'  
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
FROM `stitch-test-296708.mysql.Transaction`
WHERE (transactionstatus='Success' OR transactionstatus='RollBack')
AND (  transactiontype='Deposit' 
    OR transactiontype='Withdraw' 
    OR transactiontype='Vendor2User' 
    OR transactiontype = 'Agent2User'
    OR transactiontype = 'User2Agent' )
AND creditamount <> 0
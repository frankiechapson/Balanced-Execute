create or replace procedure P_BALANCED_EXECUTE( I_SQL in varchar2
                                              , I_MP number default 1
                                              ) is

    L_STIME timestamp(9);
    L_ETIME timestamp(9);

    function FS_TIMESTAMP_DIFF_IN_SECONDS (I_TS1 in timestamp, I_TS2 in timestamp) return number is 
        L_TOTAL_SECS    number;  
        L_DIFF          interval day(9) to second(6);  
    begin 
        L_DIFF       := I_TS2 - I_TS1;  
        L_TOTAL_SECS := abs(extract(second from L_DIFF) + extract(minute from L_DIFF)*60 
                      + extract(hour from L_DIFF)*60*60 + extract(day from L_DIFF)*24*60*60);  
        return L_TOTAL_SECS;  
    end; 

begin
    L_STIME := SYSTIMESTAMP;

    execute immediate I_SQL;

    L_ETIME := SYSTIMESTAMP;

    dbms_lock.sleep( FS_TIMESTAMP_DIFF_IN_SECONDS(L_STIME,L_ETIME)  * I_MP );

end;
/

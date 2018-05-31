
# Balanced Execute

## Oracle PL/SQL solution to execute command


### Why?

When you processing too much data and it takes long time, the other processes have not any chance to run because the main process use up all the resources.

### How?

If that is possible split up the long process into smaller pieces.  
And use this **P_BALANCED_EXECUTE** procedure.
This executes I_SQL then SLEEPs for as long as long as the execution took.  
So, this leaves other processes to run. However, if the system is overloaded, it takes longer execute time, and it waits longer, so leaves more time to others to run.
If the system is not loaded, it can run faster and more frequent.

With I_MP, you can adjust the waiting time with the execution time eg.:  
2 => wait twice as long as it has run, 0.5 => half wait, etc.

It uses the

    dbms_lock.sleep

procedure, so you have to be granted to execute it!


### Example:

    begin
        for L_R in ( select ID from REDMINE_DATA_TO_IMPORT_VW )
        loop
            P_BALANCED_EXECUTE( 'begin REDMINE_DATA_PROCESS('||L_R.ID||'); end;');
        end loop;
    end;

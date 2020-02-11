libname instream XML; 		/* Definition to get the data from Excel	*/ 
libname data "C:\data"; 	/* Library for data to be changed 			*/ 
  
proc copy in=instream out=work; /*Copy XML stream info SAS Dataset for later use*/ 
run;  
  
proc sql;  
	update data.cars_update t1 					/* Update our existing dataset*/ 
		set cylinders = (select cylinders  
			from work.excel_table  
				where t1.id = id)  
				where id in (select id 			/*Update only rows that are changed*/  
					from work.excel_table);  
quit;  
 
/* 
One SQL update explaned here: https://communities.sas.com/t5/SAS-Procedures/update-statement-inside-a-proc-sql/td-p/47964 

Notes for Stored Process definition:
Execution Options -> Result capabilities = Streaming
Data Sources and Targets -> Data Sources (input streams to a stored process)->
Form of Data: XML based data
Fileref:instream
Allow rewinding stream: check
Label: instream
 
*/
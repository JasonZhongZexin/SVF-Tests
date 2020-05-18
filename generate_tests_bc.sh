root=$(cd "$(dirname "$0")";pwd)
echo $root
if [ -d 'test_cases_bc' ] ; then
    echo "folder exists!"
else
    mkdir "test_cases_bc"
fi

bc_path=$root"/test_cases_bc/"

function generate_bc(){
if [ "X$1" != 'X' ]
   then
         cd "$1"
  fi
  
  files=`ls`
for filename in $files;do
	
	if [ -d $filename ]
    	then	
		generate_bc $filename 
			
	else
 
	if [ ${filename##*.} = 'cpp' ] || [ ${filename##*.} = 'c' ]
	 then
        file_path=$(cd "$(dirname "$filename")";pwd)
	    echo $file_path"/"$filename
        clang -c -emit-llvm $file_path"/"$filename -o $bc_path$filename".bc"
	fi
	
	fi
done
	cd ..
}

generate_bc
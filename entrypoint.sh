#! /bin/bash -l

REL_TYPE="${1}"
CURR_VER="${2}"

if [[ ${CURR_VER} == "" ]]
then
	NEW_TAG="1.0.0"
else
	PREFIX=$(echo ${CURR_VER} | grep -E '^[a-zA-Z]' &>/dev/null && echo "${CURR_VER}" | tr '[0-9]' ' ' | awk -F ' ' '{print $1}' || echo '	')
	VERSION=$(echo "${CURR_VER}" | awk -F "${PREFIX}" '{print $NF}')
	VERLEN=$(echo ${VERSION//./ } | wc -w)
	VERARR=(${VERSION//./ })
	for i in ${!VERARR[@]}
	do
		export P$((i + 1))="${VERARR[i]}"
	done
	case ${REL_TYPE,,} in
		hotfix)
			P3=${P3:=0}
			P3=$((P3 + 1))
			[[ ${P2} == "" ]] && P2=0
			VERLEN=3
			;;
		minor)
			{ [[ ${P3} != "" ]] && P3=0; } || VERLEN=2
			P2=${P2:=0}
			P2=$((P2 + 1))
			;;
		major)
			{ [[ ${P3} != "" ]] && P3=0; } || VERLEN=2
			{ [[ ${P2} != "" ]] && P2=0; } || VERLEN=1
			P1=${P1:=0}
			P1=$((P1 + 1))
			;;
		*)
			echo "Valid values for the release_type: Major, Minor, or HotFix"
			exit 1
			;;
	esac
	for i in $(seq 0 $((VERLEN - 1)))
	do
		declare -n tmp="P$((i + 1))"
		VERARR[i]="${tmp}"
	done
	NEW_TAG=$(echo ${PREFIX}${VERARR[@]} | tr ' ' '.')
fi
echo "next-tag=${NEW_TAG}" >> $GITHUB_OUTPUT

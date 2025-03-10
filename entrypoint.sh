#! /bin/bash -l

CURR_VER="${1}"
PREFIX=$(echo ${CURR_VER} | grep -E '^[a-zA-Z]' &>/dev/null && echo "${CURR_VER}" | tr '[0-9]' ' ' | awk -F ' ' '{print $1}' || echo '	')
VERSION=$(echo "${CURR_VER}" | awk -F "${PREFIX}" '{print $NF}')
VERLEN=$(echo ${VERSION//./ } | wc -w)
VERARR=(${VERSION//./ })

if [[ "${CURR_VER}" == "" ]]
then
	NEW_TAG="0.0.1"
else
	for i in ${!VERARR[@]}
	do
		export P$((i + 1))="${VERARR[i]}"
	done

	if [[ "${P3}" -lt 20 ]]
	then
		[[ "${P3}" != "" ]] && P3=$((P3 + 1))
	elif [[ "${P2}" -lt 20 ]]
	then
		[[ "${P3}" != "" ]] && P3=0
		[[ "${P2}" != "" ]] && P2=$((P2 + 1))
	else
		[[ "${P3}" != "" ]] && P3=0
		[[ "${P2}" != "" ]] && P2=0
		P1=$((P1 + 1))
	fi

	for i in ${!VERARR[@]}
	do
		declare -n tmp="P$((i + 1))"
		VERARR[i]="${tmp}"
	done
fi
	NEW_TAG=$(echo ${PREFIX}${VERARR[@]} | tr ' ' '.')
echo "next-tag=${NEW_TAG}" >> $GITHUB_OUTPUT

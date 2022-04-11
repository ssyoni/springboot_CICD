#!/usr/bin/env bash

# 쉬고 있는 profile 찾기: real1이 사용 중이면 real2가 쉬고 있고, 반대면 real1이 쉬고 있음
function find_idle_profile()
{
    RESPONSE_CODE=$(sudo curl -s -o /dev/null -w "%{http_code}" http://3.35.50.206/profile)  # nginx가 바라보고 있는 스프링 부트가 정상적으로 수행중인지 확인

    if [ ${RESPONSE_CODE} -ge 400 ] # 400 보다 크면 (즉, 40x/50x 에러 모두 포함) / 정상 : 200, 오류 400~503
    then
        CURRENT_PROFILE=real2
    else
        CURRENT_PROFILE=$(sudo curl -s http://3.35.50.206/profile)
    fi

    if [ ${CURRENT_PROFILE} == real1 ]
    then # IDLE_PROFILE : nginx와 연결되지 않은 profile
      IDLE_PROFILE=real2
    else
      IDLE_PROFILE=real1
    fi

    echo "${IDLE_PROFILE}"
}

# 쉬고 있는 profile의 port 찾기
function find_idle_port()
{
    IDLE_PROFILE=$(find_idle_profile)

    if [ ${IDLE_PROFILE} == real1 ]
    then
      echo "8081"
    else
      echo "8082"
    fi
}
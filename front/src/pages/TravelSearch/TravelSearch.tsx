import { useState, useEffect } from 'react';
import Results from '../../components/Results';
import Button from "react-bootstrap/Button";
import Filter from '../../components/Filter';
import { ClimateListProps,TimezoneListProps,CityListProps } from './types';

export const TravelSearch = () => {

    const [resultData, setResultData ] = useState<any>([]);
    const [climateList, setClimateList] = useState<ClimateListProps[]>([]);
    const [timezoneList, setTimezoneList] = useState<TimezoneListProps[]>([]);
    const [cityList, setCityList] = useState<CityListProps[]>([]);
    const handleSearch = (dataFromServer: any) => {
        setResultData(dataFromServer);
    }
    console.log('climate:', climateList);
    useEffect(() => {
      const getClimateList = async () => {
        try {
          const res = await fetch('http://localhost:3000/getClimateList');

          if (!res?.ok) {
            throw new Error("Ошибка http: getClimateList")
          }

          const data = await res.json();
          setClimateList(data)
        } catch {
          console.log("Ошибка")
        }
      }
      getClimateList();
    }, [])


    useEffect(() => {
    const getCityList = async () => {
      try {
        const res = await fetch('http://localhost:3000/getCityList');

        if (!res?.ok) {
          throw new Error("Ошибка http: getCityList")
        }

        const data = await res.json();
        setCityList(data)
      } catch {
        console.log('Error')
      }
    }
    getCityList();
    }, [])


    console.log('timezone:', timezoneList);
    useEffect(() => {
      const getTimezoneList = async () => {
        try {
          const res = await fetch('http://localhost:3000/getTimezoneList');

          if (!res?.ok) {
            throw new Error("Ошибка http: getTimezoneList")
          }

          const data = await res.json();
          setTimezoneList(data)
        } catch {
          console.log("Ошибка")
        }
      }
      getTimezoneList();
    }, [])

    console.log('result', resultData);
    return (
        <div className="App">
          <h1>Найдите свое путешествие!</h1>
          <h2>Поиск идеи для отдыха</h2>
          <Filter handleSearch={handleSearch} climateList={climateList} timezoneList={timezoneList}/>
          <Results 
            resultData={resultData}
            climate={climateList}
            timezone={timezoneList}
            cityList={cityList}
          />
        </div>
    )
};
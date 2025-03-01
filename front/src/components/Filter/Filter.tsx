import {FC, useMemo, useState } from "react";
import {Behaviour, Dropdown} from "../Dropdown";
import { CityType, RestItemType } from './types';
import { allCities as cityOfConstants, allTypes } from './constants';
import axios from "axios";
import * as S from './Filter.styled';
import Button from "react-bootstrap/Button";

import { ClimateListProps } from '../../pages/TravelSearch/types';
import { TimezoneListProps } from '../../pages/TravelSearch/types';
interface FilterInterface {
    handleSearch: (data: any) => void;
    climateList: ClimateListProps;
    timezoneList: TimezoneListProps;
}

const Filter: FC<FilterInterface> = ({ handleSearch, climateList, timezoneList }) => {
    const [city, setCity] = useState<CityType>({ id: null, title: ''});
    const [type, setType] = useState<RestItemType[]>([]);

    const request = useMemo(() => {
        const selectNameCity = cityOfConstants.find((cityOfConstants: CityType) => cityOfConstants.id === city?.id)?.title;
        const selectRestType = type.map((type: RestItemType) => type.title);
        return {
            departureCity: selectNameCity ?? '',
            typeRest: selectRestType ?? '',
        }
    }, [city, type]);

    console.log('request', request);


    const handleUpdate = async () => {
        try {
            const response = await axios.get("http://localhost:3000/getResult", {
                params: {
                    types: type.map(item => item.id),
                    city: city?.id,
                }
            })
            handleSearch(response.data)

        } catch (error) {
            console.error("Ошибка извлечения данных: ", error);
        }
    };

    const cityLabel = useMemo(() => {
        const title = city ? `Город вылета: ${city.title}` : 'Город вылета: Выбрать';
        return <S.Label>{title}</S.Label>
    }, [city]);

    const handleReset = () =>{
        setType([]);
        setCity({ id: null, title: ''});
    }

    const typeLabel = useMemo(() => {
        return type.length ? (
            <S.Label>
                {type.map((t, index) => (
                    <S.TagSpan color={t.color} key={`${index}-tag-span`}>
                        {t.title}
                        {index !== type.length - 1 ? "," : ""}
                    </S.TagSpan>
                ))}
            </S.Label>
        ) : (
            <S.Label>Тип отдыха: Выбрать</S.Label>
        );
    }, [type]);

    return (
        <>
        <div className="App">
            <h4>Выберите параметры из списка</h4>
            <S.Controls className="Dropdown">
                <Dropdown<CityType> 
                    behaviour={Behaviour.SINGLE}
                    value={city}
                    onChange={setCity}
                    label={cityLabel}
                >
                    {cityOfConstants.map((p, index) => (
                        <Dropdown.MenuItem value={p}>{p.title}</Dropdown.MenuItem>
                    ))}
                </Dropdown>

                <Dropdown<RestItemType>
                    behaviour={Behaviour.MULTIPLE}
                    value={type}
                    onChange={setType}
                    label={typeLabel}
                >
                    {allTypes.map((t) => (
                        <Dropdown.MenuItem value={t}>
                            <S.TagSpan color={t.color}>{t.title}</S.TagSpan>
                        </Dropdown.MenuItem>
                    ))}
                </Dropdown>
            </S.Controls>
        </div>
        <Button className="Button"
             onClick={handleUpdate}            
        >
            Найти
        </Button>
        <Button className="Button1"
             onClick={handleReset}            
        >
            Очистить
        </Button>
    </>
    );
}

export default Filter;
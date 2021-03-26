package ${context.basePackage}.mapper;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.TimeZone;
import java.util.stream.Collectors;

import ${context.basePackage}.domain.AbstractDomain;
import ${context.basePackage}.dto.BaseDTO;
import ${context.basePackage}.enums.AbstractEnum;

public abstract class BaseMapper<D extends BaseDTO, M extends AbstractDomain> {

	static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
	
	public abstract M toEntity(D dto, M entity, Object parent);
	public abstract D toDTO(M entity);
	public abstract D toDTO(M entity, D dto);

	public String enumToString(AbstractEnum ennum) {
		if (ennum == null) return null;
		return ennum.getValue();
	}
	
	public <E extends AbstractEnum> E stringToEnum(String value, Class<E> clazz) {
		if (value == null) return null;
		E result = null;
		for (E en : clazz.getEnumConstants()) {
			if (en.toString().equals(value)) {
				result = en;
				break;
			}
		}
		return result;
	}

	public String dateToString(LocalDate data) {
		if (data == null) return null;
		return formatter.format(data);
	}
	
	public LocalDate stringToDate(String value) {		
		if (value == null) return null;
		return LocalDate.parse(value, formatter);
	}		
	
	public BigDecimal dateToNumber(LocalDate data) {
		if (data == null) return null;
		long mili = data.atStartOfDay(TimeZone.getDefault().toZoneId()).toInstant().toEpochMilli();
		return new BigDecimal(mili);
	}
	
	public BigDecimal dateTimeToNumber(LocalDateTime data) {
		if (data == null) return null;
		long mili = data.atZone(TimeZone.getDefault().toZoneId()).toInstant().toEpochMilli();
		return new BigDecimal(mili);
	}

	public LocalDate numberToDate(BigDecimal value) {		
		if (value == null) return null;
    	return LocalDateTime.ofInstant(Instant.ofEpochMilli(value.longValue()), TimeZone.getDefault().toZoneId()).toLocalDate();
	}	
	
	public LocalDateTime numberToDateTime(BigDecimal value) {
		if (value == null) return null;
    	return  LocalDateTime.ofInstant(Instant.ofEpochMilli(value.longValue()), TimeZone.getDefault().toZoneId());
	}	
	
	public <DD extends BaseDTO, MM extends AbstractDomain, BM extends BaseMapper<DD, MM>>  List<DD> entityListToDTOList(List<MM> entityList, List<DD> dtoList, BM mapper) {
		if (dtoList != null) 
			dtoList.clear();
		else 
			dtoList = new ArrayList<DD>();
		if (entityList == null) return dtoList;
		dtoList.addAll(entityList.stream().map(it -> mapper.toDTO(it)).collect(Collectors.toList()));
		return dtoList;
	}

	public <DD extends BaseDTO, MM extends AbstractDomain, BM extends BaseMapper<DD, MM>> List<MM> dtoListToEntityList(List<DD> dtoList, List<MM> entityList, BM mapper, Object parent) {
		if (entityList != null) 
			entityList.clear();
		else 
			entityList = new ArrayList<MM>();
		if (dtoList == null) return entityList;
		entityList.addAll(dtoList.stream().map(it -> mapper.toEntity(it, null, parent)).collect(Collectors.toList()));
		return entityList;
	}
	
}

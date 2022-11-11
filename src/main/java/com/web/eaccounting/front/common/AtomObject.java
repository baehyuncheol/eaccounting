package com.web.eaccounting.front.common;


public abstract class AtomObject {
    public abstract <D> AtomObject of(AtomObject paramAtomObject);

    protected <D> D of(AtomObject source, Class<D> destinationType) {
        if (source == null)
            return null;
        return (D) ModelMapperUtils.getModelMapper().map(source, destinationType);
    }
}
